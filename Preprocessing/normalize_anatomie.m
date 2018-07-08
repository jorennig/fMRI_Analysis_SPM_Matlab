% normalize funktionals
subjects = {'Test', 'VP01', 'VP02', 'VP03'}; 

for i = 1:size(subjects, 2)

    cd(fullfile('E:\Cloud\fMRI OBJ_Gestalt Nifti\Anatomie', subjects{i}))

    matlabbatch{1}.spm.spatial.normalise.estwrite.subj(i).vol = cellstr(spm_select('FPList', pwd, '^sOBJ.*\.nii'));
    matlabbatch{1}.spm.spatial.normalise.estwrite.subj(i).resample = cellstr(spm_select('FPList', pwd, '^sOBJ.*\.nii'));
        
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
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox = [1 1 1];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';


%%
spm_jobman('run', matlabbatch)
