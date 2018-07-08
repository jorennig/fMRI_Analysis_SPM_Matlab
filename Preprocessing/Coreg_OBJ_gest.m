% Pfad speichern (Ordner "Data")
cd 'C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti'
cf = pwd;

% Liste aller Elemente im aktuellen Ordner - nur Ordner werden behalten
d = dir(cf);
isub = [d(:).isdir]; 
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..','Gestalt_Behav_ET','Object_behav_ET', 'Anatomie', 'SB_ref'})) = []; %keine fMRI Daten

VP_list = ['Test';'VP01';'VP02'; 'VP03'];


for g = 1:size(VP_list,1)
    VP_name = VP_list(g,:)
    for i=1:numel(nameFolds) % Tasks
        cd(fullfile(cf, nameFolds{i}))
        if exist(VP_name,'dir')==7 %7=true (is folder); 0= false
            cd(fullfile(cf, nameFolds{i}, VP_name))
            taskfolder = fullfile(cf, nameFolds{i}, VP_name);
    
            % VP
            d = dir(pwd);
            isub = [d(:).isdir];
            subFolds = {d(isub).name}';
            subFolds(ismember(subFolds,{'.','..'})) = [];
            for j= 1:numel(subFolds)
                
                
                % SB auf MB 
                
                
                %cd(fullfile(taskfolder, subFolds{j}))
                %mkdir('Coreg');
                
                %cd(fullfile(taskfolder, subFolds{j}, 'R'))
                %files_list = spm_select('ExtFPList', pwd, 'rSTC*');
                %MB = files_list(1,:)
                %MB = spm_vol(MB);
        
                %cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\SB_ref', nameFolds{i}, VP_name, subFolds{j}))
                %SB = spm_select('ExtFPList', pwd, '.nii');
                %SB = spm_vol(SB);
                
                %coreg_MB_SB = spm_coreg(MB, SB)
                %spm_reslice([MB,SB],struct('which',1));
                
                cd(fullfile(taskfolder, subFolds{j}, 'R'))
                files_list = spm_select('ExtFPList', pwd, '^rSTC.*\.nii');
                MB_path = files_list(1,:)
                MB = spm_vol(MB_path);
        
                cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\SB_ref', nameFolds{i}, VP_name, subFolds{j}))
                SB_path = spm_select('ExtFPList', pwd, '.nii')
                SB = spm_vol(SB_path);
                
                coreg_MB_SB = spm_coreg(MB, SB)
                
                newspace = inv(spm_matrix(coreg_MB_SB))*spm_get_space(SB_path)
                spm_get_space(SB_path,newspace)
                %P=strvcat(spm_select('ExtFPList', pwd, '.nii'), files_list(1,:))
                %spm_reslice(P)
                P=strvcat(MB_path, SB_path);

                spm_reslice(P,struct('which',1));
                
                
                % Anatomie auf SB
                
                cd(fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\SB_ref', nameFolds{i}, VP_name, subFolds{j}))
                SB_r_path = spm_select('ExtFPList', pwd, '^rfOBJ.*\.nii')
                SB_r = spm_vol(SB_r_path);
        
                cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\Anatomie', VP_name))
                Anat_path = spm_select('ExtFPList', pwd, '.nii')
                Anat = spm_vol(Anat_path);
                
                coreg_SB_r_Anat = spm_coreg(SB_r, Anat)
                
                newspace_anat = inv(spm_matrix(coreg_SB_r_Anat))*spm_get_space(Anat_path)
                spm_get_space(Anat_path,newspace_anat)
                
                P=strvcat(SB_r_path, Anat_path);
                spm_reslice(P,struct('which',1));
                
                cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\Anatomie', VP_name))
                    if ~isempty(dir('r*.nii')) ==1
                        movefile ('r*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, VP_name, subFolds{j},'Coreg'))
                    end
                    if ~isempty(dir('meanr*.nii'))==1
                        movefile ('meanr*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, VP_name, subFolds{j},'Coreg'))
                    end
                
                cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\SB_ref', nameFolds{i}, VP_name, subFolds{j}))
                    if ~isempty(dir('r*.nii')) ==1
                        movefile ('r*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, VP_name, subFolds{j},'Coreg'))
                    end
                    if ~isempty(dir('meanr*.nii'))==1
                        movefile ('meanr*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, VP_name, subFolds{j},'Coreg'))
                    end
            end
        end
    end   
end
    

