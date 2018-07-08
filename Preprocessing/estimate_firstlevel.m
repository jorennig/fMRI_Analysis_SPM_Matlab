% standardisiert: standardized = 1, Preprocessing = 3
% nichtstandardisiert: standardized = 2, Preprocessing = 2


ESTIMATE_GLM = 1;
Preprocessing = 2; % 1= realign first 2=STC first 3= STC first + normalized--> wir machen 2/3
standardized = 2; %1 ja, 2 nein
Preprocessing_outputs = {'Results fMRT_realign first', 'Results fMRT', 'Results fMRT'};
Preprocessing_smooth_pre = {'^sSTC.*\.nii$', '^srrSTC.*\.nii$', '^swrrSTC.*\.nii$'};
STC_realign = {'STC', 'R', 'R'};
Smooth_folder = {'Smooth_normalized', 'Smooth'}
Output_s = {'standardized', 'non_standardized'}

subjects = {'Test', 'VP01', 'VP02', 'VP03'}; 
sessions = {'Gestalt_Solid', 'Gestalt_Standard', 'Object_Standard'};

for i = 1:size(subjects, 2)
    outputDir = char(fullfile('H:\fmrt\Results_fMRI\', subjects(i), Output_s(standardized)))
    cd(outputDir)
    
    if ESTIMATE_GLM == 1
        load SPM;
        spm_spm(SPM);
    end
end