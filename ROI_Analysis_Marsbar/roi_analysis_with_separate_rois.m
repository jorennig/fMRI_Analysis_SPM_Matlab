% Create folder (e.g. 'ROI_Analysis') in 'path_vp' (see below), place
% script there
clc
clear all
close all

%% Path data folders (contain SPM.mat file, first level)
path_vp = 'D:\Ordnung\Projekt mit JRennig\fMRT\Sub_1_level\complete_range';

% Get rois (have to be in start folder, no other .mat file allowed)
path_roi = 'D:\Ordnung\Projekt mit JRennig\fMRT\Sub_1_level\complete_range\ROI_final';
cd(path_roi);
rois = dir('vp*.mat');
rois_n = cell(length(rois),1);

for i=1:length(rois)
    rois_n{i} = rois(i).name;
end

cd(path_vp);
spm_mat_n = cell(length(rois),1);
for i=1:length(rois)
    curRoi = rois_n{i};
    spm_mat_n{i} = [curRoi(1:2) curRoi(4:5)];
end

%% Assemble path of SPM.mat files. 
spm_name = cell(1,length(spm_mat)); 
for i=1:length(spm_mat_n)
    spm_name{i} = [path_vp '\' spm_mat_n{i} '\SPM.mat'];    
end

%% Switch on Marsbar
marsbar('on');

%% ROIs to extract data from
roi_file_n = cell(1,length(rois)); 
for i=1:length(rois)
    roi_file_n{i} = [path_roi '\' rois_n{i}];
end

%% extract %-signal change (for details see Marsbar manual)
for j = 1:length(rois) % j: subject mat file counter

     % print files
     spm_file = spm_name{j};
     roi_file = roi_file_n{j};
    
     % Load design   
     D = mardo(spm_name{j});
     %D = autocorr(D, 'fmristat', 2); % to avoid the ReML error
     % Load ROI into analysis
     R = maroi(roi_file_n{j});
     % Marsbar data object
     Y = get_marsy(R, D, 'mean');
     % Estimate design on data object
     E = estimate(D, Y);

     % e_specs = 1. row: session, 2. row: number of event; e_names = name of events
     [e_specs, e_names] = event_specs(E);
     
     % Extraction of event types/names
     ets = event_types_named(E);
     n_event_types = length(ets);
     n_events = size(e_specs, 2);
     dur = 0;

     % extract % signal change, creates % per event
     data = []; % empty data vector at start of each roi assessed

     for e_s = 1:n_events
         pct_ev(e_s) = event_signal(E, e_specs(:,e_s), dur);
         data(e_s) = pct_ev(e_s);
     end

     data_ges(j,1:length(e_names)) = data;
     
end

%% write end result into excel file         
data_title = [e_names; num2cell(data_ges)]; 
xlswrite('individual_ROI.xls',data_title);
