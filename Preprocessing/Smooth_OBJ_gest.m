% Pfad speichern (Ordner "Data")
cd 'C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti'
cf = pwd;

% Liste aller Elemente im aktuellen Ordner - nur Ordner werden behalten
d = dir(cf);
isub = [d(:).isdir]; 
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..','Gestalt_Behav_ET','Object_Behav_ET', 'Anatomie', 'SB_ref'})) = []; %keine fMRI Daten

for i=1:numel(nameFolds) % Tasks
    cd(fullfile(cf, nameFolds{i}))
    taskfolder = fullfile(cf, nameFolds{i});
    
    % VP
    d = dir(pwd);
    isub = [d(:).isdir];
    subFolds = {d(isub).name}';
    subFolds(ismember(subFolds,{'.','..'})) = [];
    for j= 1:numel(subFolds)
        cd(fullfile(taskfolder, subFolds{j}))
        trialfolder = fullfile(taskfolder, subFolds{j});
            
        d = dir(pwd);
        isub = [d(:).isdir]; 
        trialFolds = {d(isub).name}';
        trialFolds(ismember(trialFolds,{'.','..'})) = [];
    
        for k = 1:numel(trialFolds) %Trials
            cd(fullfile(trialfolder, trialFolds{k}, 'R'))
            files_names = spm_select('list', pwd, '^r.*\.nii');
            files_path = spm_select('ExtFPList', pwd, '^r.*\.nii');
            mkdir(fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k},'Smooth'));

            for l = 1:numel(dir('r*.nii'))
                curr_file = files_path(l,:)
                smooth_file = fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k},'Smooth',  strcat('s', files_names(l,:)));
                spm_smooth(curr_file, smooth_file, 4)
            end
          
        end
    end
end
