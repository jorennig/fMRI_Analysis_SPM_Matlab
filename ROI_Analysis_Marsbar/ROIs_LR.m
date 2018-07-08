clc
clear all
close all

% Mask for LH and RH
roi_delete = zeros(31,76,63);
roi_keep = ones(32,76,63);
mask_left = [roi_keep; roi_delete];
mask_right = [roi_delete; roi_keep];

% Get ROIs
data_files = dir('*.nii');
data_files_neu = cell(length(data_files),1);
for w=1:length(data_files)
    data_files_neu{w} = data_files(w).name;
end    
data_files = data_files_neu;
clear data_files_neu w

size_l = zeros(numel(data_files),1);
size_r = zeros(numel(data_files),1);

for i = 1:numel(data_files)
    
    file = data_files{i};
    roi = load_nii(file); 

    roi_l = roi;
    roi_r = roi;
    
    rl = roi_l.img.*mask_left;
    roi_l.img = rl;
    bin = roi_l.img >= 1;
    size_l(i) = sum(sum(sum(bin)));
    
    save_nii(roi_l,[file '_L.nii']);

    rr = roi_r.img.*mask_right;
    roi_r.img = rr;
    bin = roi_r.img >= 1;
    size_r(i) = sum(sum(sum(bin)));
    
    save_nii(roi_r,[file '_R.nii']);

end

ROI_size_LR = [size_l size_r]; % ROI size LH, RH

save('ROI_size_LR.mat','ROI_size_LR');
