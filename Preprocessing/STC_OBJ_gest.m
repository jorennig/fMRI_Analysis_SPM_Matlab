% Pfad speichern (Ordner "Data")
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
            cd(fullfile(trialfolder, trialFolds{k}))
            files = spm_select('list', pwd, '0*');
            hdr = spm_dicom_headers(files);
            
            cd (fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k}))  
            mkdir('STC');

            for l = 1:numel(dir('*.nii'))
                sliceOrder = hdr{1,l}.Private_0019_1029;
                files = spm_select('List', pwd); 
                TR = hdr{1,l}.RepetitionTime;
                %reference slice in ms
                %Reihenfolge in ms bei multiband
                %Reihenfolge erwartet in "foot to head" (Michael Erb: wenn
                %man nchts umstellt ist das so default.
                spm_slice_timing(files(l,:), sliceOrder, median(sliceOrder), [0 TR], 'STC_');
                movefile (char(strcat('STC_',files(l,:))), fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti', nameFolds{i}, subFolds{j},trialFolds{k},'STC'))
            end
          
        end
    end
end
