clc
clear all
close all

dir_lr_ap = 'ROIs_LR_ant_post';
mkdir(dir_lr_ap);
path_c = pwd;
path_roi = [path_c '/' dir_lr_ap];

% Get TPJ masks
data_files = dir('rr*ant.nii');
data_files_neu = cell(length(data_files),1);
for w=1:length(data_files)
    data_files_neu{w} = data_files(w).name;
end    
data_files_ant = data_files_neu;
clear data_files_neu w

data_files = dir('rr*post.nii');
data_files_neu = cell(length(data_files),1);
for w=1:length(data_files)
    data_files_neu{w} = data_files(w).name;
end    
data_files_post = data_files_neu;
clear data_files_neu w

mask_ant_post = [data_files_ant; data_files_post];
clear data_files_ant data_files_post

% Get ROIs
data_files = dir('vp*.nii');
data_files_neu = cell(length(data_files),1);
for w=1:length(data_files)
    data_files_neu{w} = data_files(w).name;
end    
data_files = data_files_neu;
clear data_files_neu w

% Create left/right anterior/posterior
for i = 1:numel(data_files)
    
    file = data_files{i};
    [pathstr,roi_name,ext] = fileparts(data_files{i});
    %bb.(['bb_' num2str(i)]) = spm_get_bbox(file);
    
    for j = 1:numel(mask_ant_post)
        
        file_m = mask_ant_post{j};
        mask_roi = load_nii(file_m);
        [pathstr,mask_name,ext] = fileparts(mask_ant_post{j});
        mask_name = mask_name(6:end);
        name_roi = [roi_name mask_name ext];
        
        mask_roi_img = single(mask_roi.img);
        
        roi = load_nii(file);
        roi_n = roi.img.*mask_roi_img;
        bin = roi_n >= 1;
        roi.img = bin;
        size = sum(sum(sum(bin)));

        save_nii(roi,[path_roi '/' name_roi]);
    
    end
end

%ROI_size_LR = [size_l size_r]; % ROI size LH, RH

%save('ROI_size_LR.mat','ROI_size_LR');

display('Done!');
