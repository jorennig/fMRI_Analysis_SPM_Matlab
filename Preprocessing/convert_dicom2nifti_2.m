% Pfad speichern (Ordner "Data")
cf = pwd;

% Liste aller Elemente im aktuellen Ordner - nur Ordner werden behalten
d = dir(cf);
isub = [d(:).isdir]; 
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..','Gestalt_Behav_ET','Object_Behav_ET'})) = []; %keine fMRI Daten

for i=1:numel(nameFolds) % Tasks
    cd(fullfile(cf, nameFolds{i}))
    taskfolder = fullfile(cf, nameFolds{i});
    
    % VP
    d = dir(pwd);
    isub = [d(:).isdir];
    subFolds = {d(isub).name}';
    subFolds(ismember(subFolds,{'.','..'})) = [];
    
    if nameFolds{i} == string('Anatomie')
        
        for j= 1:numel(subFolds)
            cd(fullfile(taskfolder, subFolds{j}))
            files = spm_select('list', pwd, '0*');
            hdr = spm_dicom_headers(files);
            outpath = fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\', nameFolds{i}, subFolds{j})
            
            spm_dicom_convert(hdr,'all','flat','nii',outpath);
            %filepath = pwd
            %dicm2nii(filepath, outpath, '3D.nii')
        end
    
    elseif nameFolds{i} == string('SB_ref')
        for l= 1:numel(subFolds)
            cd(fullfile(taskfolder, subFolds{l}))
            idfolder = fullfile(taskfolder, subFolds{l});
            
            d = dir(pwd);
            isub = [d(:).isdir]; 
            VPFolds = {d(isub).name}';
            VPFolds(ismember(VPFolds,{'.','..'})) = [];
    
            for m = 1:numel(VPFolds) %VP
                cd(fullfile(idfolder, VPFolds{m}))
                taskreffolder = fullfile(idfolder, VPFolds{m});
                
                d = dir(pwd);
                isub = [d(:).isdir]; 
                taskrefFolds = {d(isub).name}';
                taskrefFolds(ismember(taskrefFolds,{'.','..'})) = [];
                
                for n = 1:numel(taskrefFolds)%trial
                    cd(fullfile(taskreffolder, taskrefFolds{n}))
                    
                    files = spm_select('list', pwd, '0*');
                    hdr = spm_dicom_headers(files);
                    outpath = fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\', nameFolds{i}, subFolds{l}, VPFolds{m}, taskrefFolds{n})
                
                    spm_dicom_convert(hdr,'all','flat','nii',outpath);
                end
            end
        end
        
    else
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
                outpath = fullfile('C:\Users\Sophia\Daten\fmrt\fMRI OBJ_Gestalt Nifti\', nameFolds{i}, subFolds{j}, trialFolds{k})
                
                spm_dicom_convert(hdr,'all','flat','nii',outpath);
                %filepath = pwd
                %dicm2nii(filepath, outpath, '3D.nii')
            end
        end
    end
end
