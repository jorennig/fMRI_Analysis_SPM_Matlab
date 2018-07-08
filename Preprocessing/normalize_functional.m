% normalize funktionals
subjects = {'Test', 'VP01', 'VP02', 'VP03'}; 
sessions = {'Gestalt_Solid', 'Gestalt_Standard', 'Object_Standard'};
t=0

for i = 1:size(subjects, 2)
    currfiles = []
    for j = 1:size(sessions, 2)
        
        if exist(fullfile('E:\Cloud\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i})) ==7
            cd(fullfile('E:\Cloud\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i}))
            d = dir(pwd);
            isub = [d(:).isdir];
            subFolds = {d(isub).name}';
            subFolds(ismember(subFolds,{'.','..'})) = [];

            for k = 1:size(subFolds,1)
                cd(fullfile('E:\Cloud\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i}, subFolds{k}, 'normalized'))
                currpath = fullfile('E:\Cloud\fMRI OBJ_Gestalt Nifti', sessions {j}, subjects{i}, subFolds{k}, 'normalized'); 
                currfiles = [currfiles; cellstr(spm_select('FPList', currpath, '^arfOBJ.*\.nii'))];

                matlabbatch{1}.spm.spatial.normalise.estwrite.subj(i).vol = {currfiles{1}};
                matlabbatch{1}.spm.spatial.normalise.estwrite.subj(i).resample = currfiles;

            end
        end
        
    end
end

%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.tpm = {'C:\Program Files\MATLAB\R2016b\spm12\tpm\TPM.nii'};
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.affreg = 'mni';
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.bb = [-78 -112 -70
                                                             78 76 85];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox = [2 2 2];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';


%%
spm_jobman('run', matlabbatch)
