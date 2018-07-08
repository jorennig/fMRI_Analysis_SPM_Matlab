clear

ESTIMATE_GLM = 1;
standardized = 2; %1 ja, 2 nein
Preprocessing_smooth_pre = {'^swarf.*\.nii$','^sarf.*\.nii$'};

subjects = {'Test', 'VP01', 'VP02', 'VP03'}; 
sessions = {'Gestalt_Solid', 'Gestalt_Standard', 'Object_Standard'};

for i = 1:size(subjects, 2)
    t=0;

    for j = 1:size(sessions, 2)
        
        if exist(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i})) ==7
            
            cd(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i}))
            d = dir(pwd);
            isub = [d(:).isdir];
            subFolds = {d(isub).name}';
            subFolds(ismember(subFolds,{'.','..'})) = [];

            for k = 1:size(subFolds,1)
                t=t+1; 

                if standardized==1
                    if exist(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', subjects{i})) ~=7
                        mkdir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', subjects{i}))
                    end
                    if exist(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', 'Modell', subjects{i})) ~=7
                        mkdir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', 'Modell', subjects{i}))
                    end
                    outputDir = char(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', subjects{i}));
                    data_path =  char(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', sessions (j), subjects(i), subFolds(k), 'normalized'));

                elseif standardized ==2
                    if exist(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', subjects{i})) ~=7
                        mkdir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', subjects{i}))
                    end
                    if exist(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', 'Modell', subjects{i})) ~=7
                        mkdir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', 'Modell', subjects{i}))
                    end                    
                    outputDir = char(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', subjects{i}));
                    data_path =  char(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', sessions (j), subjects(i), subFolds(k)));
                end
                
                matlabbatch{1,1}.spm.stats.fmri_spec.dir = {outputDir};

                % timing
                matlabbatch{1,1}.spm.stats.fmri_spec.timing.units = 'secs';
                matlabbatch{1,1}.spm.stats.fmri_spec.timing.RT = 2;
                matlabbatch{1,1}.spm.stats.fmri_spec.timing.fmri_t =23; %wenn man slicetime correction gemacht hat = anzahl slices (--> 69, aber multiband)
                matlabbatch{1,1}.spm.stats.fmri_spec.timing.fmri_t0 = 12; %wenn slicetime correction = referenceslice

                %sess

                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).scans = cellstr(spm_select('FPList',data_path ,Preprocessing_smooth_pre(standardized)));
                clear conditions_struct
                clear a
                       
                
                if strcmp(sessions(j),'Object_Standard')==1
                    clear curr_cond
                    clear cond_trial
                    clear cond_name
                    clear loc_folds
                    clear curr_fold_trial
                    
                    localizer_folds = dir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_behav_ET\behavioral', subjects{i}));
                    b = [localizer_folds(:).isdir];
                    loc_folds = {localizer_folds(b).name}';
                    loc_folds(ismember(loc_folds,{'.','..'})) = [];

                    curr_cond = char(subFolds(k));
                    curr_fold_trial = char(loc_folds(k));
                    cond_trial = curr_fold_trial(:, (size(curr_fold_trial,2)-2):size(curr_fold_trial,2));
                    cond_name = curr_fold_trial(:, 20 : size(curr_fold_trial,2)-7);%groß und kleinschreibung stimmen 
                        
                        
                    %zwischen Timing files und Condition Ordnern nicht, daher ohne ersten Buchstaben suchen; überprüfen, ob Timing file zur gleichen Condition gehört

                    for l = 1:size(loc_folds,1)
                       
                        if sum(find(cell2mat(regexp(loc_folds(l), {cond_name, cond_trial}))) ~= 0)==2 % both strings must be found
                            cond_path = fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_behav_ET\behavioral', subjects(i), loc_folds(l));
                        end
                    end
                    
                    conditions=spm_select('FPList', cond_path, '^.*\.mat');
                    condition_names =spm_select('List', cond_path, '^.*\.mat'); 
                    name = condition_names(:, 12:size(condition_names,2));
                    name = cellstr(name);
                    name = strrep(name,'.mat','');
                    for m = 1:size(name,1)
                        conditions_struct{m,1}= char(name(m));
                        a = load(conditions(m,:));
                        fields = fieldnames(a);
                        conditions_struct{m,2}= a.(fields{1});
                        conditions_struct{m,3}= repmat(0.3,1,numel(a.(fields{1})))';
                        conditions_struct{m,4}= 0;
                        conditions_struct{m,5}= 1;
                    end

                    cond=struct();

                    for n = 1:size(conditions_struct,1) 
                        cond(n).name =  conditions_struct{n};
                        cond(n).onset = conditions_struct{n,2};
                        cond(n).duration = conditions_struct{n,3};
                        cond(n).tmod = 0;
                        cond(n).pmod = struct('a',{},'b',{});
                        cond(n).orth = 1;
                    end
                    
                else
                    clear curr_cond
                    clear cond_trial
                    clear cond_name
                    clear loc_folds
                    
                    localizer_folds = dir(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti\Gestalt_Behav_ET\behavioral', subjects{i}));
                    b = [localizer_folds(:).isdir];
                    loc_folds = {localizer_folds(b).name}';
                    loc_folds(ismember(loc_folds,{'.','..'})) = [];

                    curr_cond = char(subFolds(k));
                    cond_trial = curr_cond(:, size(curr_cond,2));
                    cond_name = curr_cond(:, (cell2mat(regexp(subFolds(k), {'_'}, 'once'))+2 : size(curr_cond,2)-2));

                    for l = 1:size(loc_folds,1)
                        if sum(find(cell2mat(regexp(loc_folds(l), {cond_name, cond_trial}))) ~= 0)==2 
                           cond_path = fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti\Gestalt_Behav_ET\behavioral', subjects(i), loc_folds(l));
                        end
                    end
                    
                    conditions=spm_select('FPList', cond_path, '^.*\.mat');
                    condition_names =spm_select('List', cond_path, '^.*\.mat'); 
                    name = condition_names(:, 12:size(condition_names,2));
                    name = cellstr(name);
                    name = strrep(name,'.mat','');
                    for m = 1:size(name,1)
                        conditions_struct{m,1}= char(name(m));
                        a = load(conditions(m,:));
                        fields = fieldnames(a);
                        conditions_struct{m,2}= a.(fields{1});
                        conditions_struct{m,3}= repmat(0.3,1,numel(a.(fields{1})))';
                        conditions_struct{m,4}= 0;
                        conditions_struct{m,5}= 1;
                    end

                    cond=struct();

                    for n = 1:size(conditions_struct,1) % 8 Conditions
                        cond(n).name =  conditions_struct{n};
                        cond(n).onset = conditions_struct{n,2};
                        cond(n).duration = conditions_struct{n,3};
                        cond(n).tmod = 0;
                        cond(n).pmod = struct('a',{},'b',{});
                        cond(n).orth = 1;
                    end

                end
                               

                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).cond = cond;
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).multi = {''};
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).regress = struct('name', {}, 'val', {});

                motion_path = fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', sessions (j), subjects(i), subFolds(k));
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).multi_reg = cellstr(spm_select('FPList', motion_path, '^rp_.*\.txt'));
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(t).hpf = 128;


                % fact
                matlabbatch{1,1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});

                % bases
                matlabbatch{1,1}.spm.stats.fmri_spec.bases.hrf = struct('derivs', [0 0]);

                % volt
                matlabbatch{1,1}.spm.stats.fmri_spec.volt = 1;

                %global
                matlabbatch{1,1}.spm.stats.fmri_spec.global = 'None';

                % mthresh
                matlabbatch{1,1}.spm.stats.fmri_spec.mthresh = 0.8;

                % mask
                matlabbatch{1,1}.spm.stats.fmri_spec.mask = {''};

                %cvi
                matlabbatch{1,1}.spm.stats.fmri_spec.cvi = 'AR(1)';

               % t=t+1
            end
        end
    end
    
    if standardized==1
       save(char(strcat(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', subjects{i}), '\SPM.mat')), 'matlabbatch')
       save(char(strcat(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'normalized', 'Modell', subjects{i}), '\SPM.mat')), 'matlabbatch')
    elseif standardized ==2
       save(char(strcat(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', subjects{i}), '\SPM.mat')), 'matlabbatch')
       save(char(strcat(fullfile('E:\fmrt\fMRI OBJ_Gestalt Nifti', 'Results', 'non_normalized', 'Modell', subjects{i}), '\SPM.mat')), 'matlabbatch')
    end 
     
    %Navigate to output directory, specify and estimate GLM
    cd(outputDir);
    spm_jobman('run', matlabbatch)

    if ESTIMATE_GLM == 1
        cd(outputDir);
        load SPM;
        spm_spm(SPM);
    end
    
    clear matlabbatch

end