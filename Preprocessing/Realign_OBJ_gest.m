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
    files =[]
    VP_name = VP_list(g,:)
    k=1
    for i=1:numel(nameFolds) % Tasks
        cd(fullfile(cf, nameFolds{i}))
        if exist(VP_name,'dir')==7 %7=true; 0= false
            cd(fullfile(cf, nameFolds{i}, VP_name))
            taskfolder = fullfile(cf, nameFolds{i}, VP_name);
    
            % VP
            d = dir(pwd);
            isub = [d(:).isdir];
            subFolds = {d(isub).name}';
            subFolds(ismember(subFolds,{'.','..'})) = [];
            for j= 1:numel(subFolds)
                cd(fullfile(taskfolder, subFolds{j}))
                mkdir('R');
                cd(fullfile(taskfolder, subFolds{j}, 'STC'))
        
                files_list = spm_select('ExtFPList', pwd, 'STC*');
                files{k} = str2mat(files_list)
                k=k+1
            end
        end
    end
    spm_realign(files)
    spm_reslice(files)
    
end
    
cd 'C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti'

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
           if exist(VP_name,'dir')==7 %7=true; 0= false
                cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k}, 'STC'))  
            
                 if ~isempty(dir('r*.nii'))==1
                    movefile ('r*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k}, 'R'))
                 end
                 if ~isempty(dir('r*.txt'))==1
                     movefile ('r*.txt', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k}, 'R'))
                 end
                 if ~isempty(dir('mean*.nii'))==1
                     movefile ('mean*.nii', fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k}, 'R'))
                 end
           end
        end
    end
end


