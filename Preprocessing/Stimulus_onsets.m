cd 'H:\fmrt\fMRI OBJ_Gestalt Nifti'
cf = pwd;

subjects = ['Test';'VP01';'VP02'; 'VP03'];

for g = 1:size(subjects,1)
    VP_name = subjects(g,:);
    k=1;
    
    cd(fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name))
        

    file = spm_select('List', pwd, 'localizer_standard_run1');
    if ~isempty(dir(file))==1
        mkdir ('localizer_standard_run1')

        fid = fopen(file,'r');
        C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
        C = C{1};
        fclose(fid);
        
        onsets =[];
        onset = C(:,1);

        onset(contains(onset(:,:),'press')) = [];
        onset(contains(onset(:,:),'null')) = [];
        onset(contains(onset(:,:),'trigger')) = [];

        cicle_in = onset(contains(onset(:,:),'in_c'));
        cicle_con = onset(contains(onset(:,:),'con_c'));

        rect_con = onset(contains(onset(:,:),'con_r'));
        rect_in = onset(contains(onset(:,:),'in_r'));

        %2*2*2 onsets conditions aufgesplittet nach con/in, cycle/rect, scrambled 20/80
        rect_in_02 = rect_in(contains(rect_in(:,:),'_02.'));
        rect_in_08 = rect_in(contains(rect_in(:,:),'_08.'));

        rect_con_02 = rect_con(contains(rect_con(:,:),'_02.'));
        rect_con_08 = rect_con(contains(rect_con(:,:),'_08.'));

        cicle_con_02 = cicle_con(contains(cicle_con(:,:),'_02.'));
        cicle_con_08 = cicle_con(contains(cicle_con(:,:),'_08.'));

        cicle_in_02 = cicle_in(contains(cicle_in(:,:),'_02.'));
        cicle_in_08 = cicle_in(contains(cicle_in(:,:),'_08.'));

        % Zeit rausschreiben
        % cicle_con_02
        onset_cicle_con_02 = regexp(cicle_con_02,'\d*','Match');

        for i=1:size(onset_cicle_con_02, 1)
            time_onset_cicle_con_02(i,1) = str2double(strcat(onset_cicle_con_02{i}(5),'.', onset_cicle_con_02{i}(6)));
        end
        save('time_onset_cicle_con_02','time_onset_cicle_con_02')
        movefile ('time_onset_cicle_con_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))

        % cicle_con_08
        onset_cicle_con_08 = regexp(cicle_con_08,'\d*','Match');

        for i=1:size(onset_cicle_con_08, 1)
            time_onset_cicle_con_08(i,1) = str2double(strcat(onset_cicle_con_08{i}(5),'.', onset_cicle_con_08{i}(6)));
        end
        save('time_onset_cicle_con_08','time_onset_cicle_con_08')
        movefile ('time_onset_cicle_con_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))

        % cicle_in_02
        onset_cicle_in_02 = regexp(cicle_in_02,'\d*','Match');

        for i=1:size(onset_cicle_in_02, 1)
            time_onset_cicle_in_02(i,1) = str2double(strcat(onset_cicle_in_02{i}(5),'.', onset_cicle_in_02{i}(6)));
        end
        save('time_onset_cicle_in_02', 'time_onset_cicle_in_02')
        movefile ('time_onset_cicle_in_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))


        % cicle_in_08
        onset_cicle_in_08 = regexp(cicle_in_08,'\d*','Match');

        for i=1:size(onset_cicle_in_08, 1)
            time_onset_cicle_in_08(i,1) = str2double(strcat(onset_cicle_in_08{i}(5),'.', onset_cicle_in_08{i}(6)));
        end
        save('time_onset_cicle_in_08','time_onset_cicle_in_08')
        movefile ('time_onset_cicle_in_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))

        % rect_con_02
        onset_rect_con_02 = regexp(rect_con_02,'\d*','Match');

        for i=1:size(onset_rect_con_02, 1)
            time_onset_rect_con_02(i,1) = str2double(strcat(onset_rect_con_02{i}(5),'.', onset_rect_con_02{i}(6)));
        end
        save('time_onset_rect_con_02', 'time_onset_rect_con_02')
        movefile ('time_onset_rect_con_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))


        % rect_con_08
        onset_rect_con_08 = regexp(rect_con_08,'\d*','Match');

        for i=1:size(onset_rect_con_08, 1)
            time_onset_rect_con_08(i,1) = str2double(strcat(onset_rect_con_08{i}(5),'.', onset_rect_con_08{i}(6)));
        end
        save('time_onset_rect_con_08', 'time_onset_rect_con_08')
        movefile ('time_onset_rect_con_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))

        % rect_in_02
        onset_rect_in_02 = regexp(rect_in_02,'\d*','Match');

        for i=1:size(onset_rect_in_02, 1)
            time_onset_rect_in_02(i,1) = str2double(strcat(onset_rect_in_02{i}(5),'.', onset_rect_in_02{i}(6)));
        end
        save('time_onset_rect_in_02', 'time_onset_rect_in_02')
        movefile ('time_onset_rect_in_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))


        % rect_in_08
        onset_rect_in_08 = regexp(rect_in_08,'\d*','Match');

        for i=1:size(onset_rect_in_08, 1)
            time_onset_rect_in_08(i,1) = str2double(strcat(onset_rect_in_08{i}(5),'.', onset_rect_in_08{i}(6)));
        end
        save('time_onset_rect_in_08', 'time_onset_rect_in_08')
        movefile ('time_onset_rect_in_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run1'))

    end

    file = spm_select('List', pwd, 'localizer_standard_run2');
    if ~isempty(dir(file))==1
        mkdir ('localizer_standard_run2')

        fid = fopen(file,'r');
        C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
        C = C{1};
        fclose(fid);

        onsets =[];
        onset = C(:,1);

        onset(contains(onset(:,:),'press')) = [];
        onset(contains(onset(:,:),'null')) = [];
        onset(contains(onset(:,:),'trigger')) = [];

        cicle_in = onset(contains(onset(:,:),'in_c'));
        cicle_con = onset(contains(onset(:,:),'con_c'));

        rect_con = onset(contains(onset(:,:),'con_r'));
        rect_in = onset(contains(onset(:,:),'in_r'));

        %2*2*2 onsets conditions aufgesplittet nach con/in, cycle/rect, scrambled 20/80
        rect_in_02 = rect_in(contains(rect_in(:,:),'_02.'));
        rect_in_08 = rect_in(contains(rect_in(:,:),'_08.'));

        rect_con_02 = rect_con(contains(rect_con(:,:),'_02.'));
        rect_con_08 = rect_con(contains(rect_con(:,:),'_08.'));

        cicle_con_02 = cicle_con(contains(cicle_con(:,:),'_02.'));
        cicle_con_08 = cicle_con(contains(cicle_con(:,:),'_08.'));

        cicle_in_02 = cicle_in(contains(cicle_in(:,:),'_02.'));
        cicle_in_08 = cicle_in(contains(cicle_in(:,:),'_08.'));

        % Zeit rausschreiben
        % cicle_con_02
        onset_cicle_con_02 = regexp(cicle_con_02,'\d*','Match');

        for i=1:size(onset_cicle_con_02, 1)
            time_onset_cicle_con_02(i,1) = str2double(strcat(onset_cicle_con_02{i}(5),'.', onset_cicle_con_02{i}(6)));
        end
        save('time_onset_cicle_con_02', 'time_onset_cicle_con_02')
        movefile ('time_onset_cicle_con_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))

        % cicle_con_08
        onset_cicle_con_08 = regexp(cicle_con_08,'\d*','Match');

        for i=1:size(onset_cicle_con_08, 1)
            time_onset_cicle_con_08(i,1) = str2double(strcat(onset_cicle_con_08{i}(5),'.', onset_cicle_con_08{i}(6)));
        end
        save('time_onset_cicle_con_08', 'time_onset_cicle_con_08')
        movefile ('time_onset_cicle_con_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))

        % cicle_in_02
        onset_cicle_in_02 = regexp(cicle_in_02,'\d*','Match');

        for i=1:size(onset_cicle_in_02, 1)
            time_onset_cicle_in_02(i,1) = str2double(strcat(onset_cicle_in_02{i}(5),'.', onset_cicle_in_02{i}(6)));
        end
        save('time_onset_cicle_in_02', 'time_onset_cicle_in_02')
        movefile ('time_onset_cicle_in_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))


        % cicle_in_08
        onset_cicle_in_08 = regexp(cicle_in_08,'\d*','Match');

        for i=1:size(onset_cicle_in_08, 1)
            time_onset_cicle_in_08(i,1) = str2double(strcat(onset_cicle_in_08{i}(5),'.', onset_cicle_in_08{i}(6)));
        end
        save('time_onset_cicle_in_08', 'time_onset_cicle_in_08')
        movefile ('time_onset_cicle_in_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))

        % rect_con_02
        onset_rect_con_02 = regexp(rect_con_02,'\d*','Match');

        for i=1:size(onset_rect_con_02, 1)
            time_onset_rect_con_02(i,1) = str2double(strcat(onset_rect_con_02{i}(5),'.', onset_rect_con_02{i}(6)));
        end
        save('time_onset_rect_con_02', 'time_onset_rect_con_02')
        movefile ('time_onset_rect_con_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))


        % rect_con_08
        onset_rect_con_08 = regexp(rect_con_08,'\d*','Match');

        for i=1:size(onset_rect_con_08, 1)
            time_onset_rect_con_08(i,1) = str2double(strcat(onset_rect_con_08{i}(5),'.', onset_rect_con_08{i}(6)));
        end
        save('time_onset_rect_con_08', 'time_onset_rect_con_08')
        movefile ('time_onset_rect_con_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))

        % rect_in_02
        onset_rect_in_02 = regexp(rect_in_02,'\d*','Match');

        for i=1:size(onset_rect_in_02, 1)
            time_onset_rect_in_02(i,1) = str2double(strcat(onset_rect_in_02{i}(5),'.', onset_rect_in_02{i}(6)));
        end
        save('time_onset_rect_in_02', 'time_onset_rect_in_02')
        movefile ('time_onset_rect_in_02.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))


        % rect_in_08
        onset_rect_in_08 = regexp(rect_in_08,'\d*','Match');

        for i=1:size(onset_rect_in_08, 1)
            time_onset_rect_in_08(i,1) = str2double(strcat(onset_rect_in_08{i}(5),'.', onset_rect_in_08{i}(6)));
        end
        save('time_onset_rect_in_08', 'time_onset_rect_in_08')
        movefile ('time_onset_rect_in_08.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_standard_run2'))

    end

    % solid
    file = spm_select('List', pwd, 'localizer_solid_run1');
    if ~isempty(dir(file))==1
        mkdir ('localizer_solid_run1')

        fid = fopen(file,'r');
        C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
        C = C{1};
        fclose(fid);

        onsets =[];
        onset = C(:,1);

        onset(contains(onset(:,:),'press')) = [];
        onset(contains(onset(:,:),'null')) = [];
        onset(contains(onset(:,:),'trigger')) = [];

       cicle_solid = onset(contains(onset(:,:),'s_c_'));
        rect_solid = onset(contains(onset(:,:),'s_r_'));
        cicle_scr_i = onset(contains(onset(:,:),'in_c'));
        cicle_scr_c = onset(contains(onset(:,:),'con_c'));
        rect_scr_i =  onset(contains(onset(:,:),'in_r'));
        rect_scr_c =  onset(contains(onset(:,:),'con_r'));
        
        % Zeit rausschreiben
        % cicle
        onset_cicle = regexp(cicle_solid,'\d*','Match');

        for i=1:size(onset_cicle, 1)
            time_onset_cicle(i,1) = str2double(strcat(onset_cicle{i}(4),'.', onset_cicle{i}(5)));
        end
        save('time_onset_cicle', 'time_onset_cicle')
        movefile ('time_onset_cicle.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))

        onset_cicle_scr_i = regexp(cicle_scr_i,'\d*','Match');

        for i=1:size(onset_cicle_scr_i, 1)
            time_onset_cicle_scr_i(i,1) = str2double(strcat(onset_cicle_scr_i{i}(5),'.', onset_cicle_scr_i{i}(6)));
        end
        save('time_onset_cicle_scr_i', 'time_onset_cicle_scr_i')
        movefile ('time_onset_cicle_scr_i.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))
        
        onset_cicle_scr_c = regexp(cicle_scr_c,'\d*','Match');

        for i=1:size(onset_cicle_scr_c, 1)
            time_onset_cicle_scr_c(i,1) = str2double(strcat(onset_cicle_scr_c{i}(5),'.', onset_cicle_scr_c{i}(6)));
        end
        save('time_onset_cicle_scr_c', 'time_onset_cicle_scr_c')
        movefile ('time_onset_cicle_scr_c.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))
        
        % rect
        onset_rect = regexp(rect_solid,'\d*','Match');

        for i=1:size(onset_rect, 1)
            time_onset_rect(i,1) = str2double(strcat(onset_rect{i}(4),'.', onset_rect{i}(5)));
        end
        save('time_onset_rect', 'time_onset_rect')
        movefile ('time_onset_rect.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))
        
        
       onset_rect_scr_i = regexp(rect_scr_i,'\d*','Match');

        for i=1:size(onset_rect_scr_i, 1)
            time_onset_rect_scr_i(i,1) = str2double(strcat(onset_rect_scr_i{i}(5),'.', onset_rect_scr_i{i}(6)));
        end
        save('time_onset_rect_scr_i', 'time_onset_rect_scr_i')
        movefile ('time_onset_rect_scr_i.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))
        
        onset_rect_scr_c = regexp(rect_scr_c,'\d*','Match');

        for i=1:size(onset_rect_scr_c, 1)
            time_onset_rect_scr_c(i,1) = str2double(strcat(onset_rect_scr_c{i}(5),'.', onset_rect_scr_c{i}(6)));
        end
        save('time_onset_rect_scr_c', 'time_onset_rect_scr_c')
        movefile ('time_onset_rect_scr_c.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run1'))
        
    end

    file = spm_select('List', pwd, 'localizer_solid_run2');
    if ~isempty(dir(file))==1
        mkdir ('localizer_solid_run2')

        fid = fopen(file,'r');
        C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
        C = C{1};
        fclose(fid);

        onsets =[];
        onset = C(:,1);

        onset(contains(onset(:,:),'press')) = [];
        onset(contains(onset(:,:),'null')) = [];
        onset(contains(onset(:,:),'trigger')) = [];

        cicle_solid = onset(contains(onset(:,:),'s_c_'));
        rect_solid = onset(contains(onset(:,:),'s_r_'));
        cicle_scr_i = onset(contains(onset(:,:),'in_c'));
        cicle_scr_c = onset(contains(onset(:,:),'con_c'));
        rect_scr_i =  onset(contains(onset(:,:),'in_r'));
        rect_scr_c =  onset(contains(onset(:,:),'con_r'));
        
        % Zeit rausschreiben
        % cicle
        onset_cicle = regexp(cicle_solid,'\d*','Match');

        for i=1:size(onset_cicle, 1)
            time_onset_cicle(i,1) = str2double(strcat(onset_cicle{i}(4),'.', onset_cicle{i}(5)));
        end
        save('time_onset_cicle', 'time_onset_cicle')
        movefile ('time_onset_cicle.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))

        onset_cicle_scr_i = regexp(cicle_scr_i,'\d*','Match');

        for i=1:size(onset_cicle_scr_i, 1)
            time_onset_cicle_scr_i(i,1) = str2double(strcat(onset_cicle_scr_i{i}(5),'.', onset_cicle_scr_i{i}(6)));
        end
        save('time_onset_cicle_scr_i', 'time_onset_cicle_scr_i')
        movefile ('time_onset_cicle_scr_i.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))
        
        onset_cicle_scr_c = regexp(cicle_scr_c,'\d*','Match');

        for i=1:size(onset_cicle_scr_c, 1)
            time_onset_cicle_scr_c(i,1) = str2double(strcat(onset_cicle_scr_c{i}(5),'.', onset_cicle_scr_c{i}(6)));
        end
        save('time_onset_cicle_scr_c', 'time_onset_cicle_scr_c')
        movefile ('time_onset_cicle_scr_c.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))
        
        % rect
        onset_rect = regexp(rect_solid,'\d*','Match');

        for i=1:size(onset_rect, 1)
            time_onset_rect(i,1) = str2double(strcat(onset_rect{i}(4),'.', onset_rect{i}(5)));
        end
        save('time_onset_rect', 'time_onset_rect')
        movefile ('time_onset_rect.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))
        
        
       onset_rect_scr_i = regexp(rect_scr_i,'\d*','Match');

        for i=1:size(onset_rect_scr_i, 1)
            time_onset_rect_scr_i(i,1) = str2double(strcat(onset_rect_scr_i{i}(5),'.', onset_rect_scr_i{i}(6)));
        end
        save('time_onset_rect_scr_i', 'time_onset_rect_scr_i')
        movefile ('time_onset_rect_scr_i.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))
        
        onset_rect_scr_c = regexp(rect_scr_c,'\d*','Match');

        for i=1:size(onset_rect_scr_c, 1)
            time_onset_rect_scr_c(i,1) = str2double(strcat(onset_rect_scr_c{i}(5),'.', onset_rect_scr_c{i}(6)));
        end
        save('time_onset_rect_scr_c', 'time_onset_rect_scr_c')
        movefile ('time_onset_rect_scr_c.mat', fullfile(cf, 'Gestalt_Behav_ET\behavioral', '\', VP_name, 'localizer_solid_run2'))
        
    end
    
    if ~isempty(dir(fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name)))==1
        cd(fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name))


        file = spm_select('List', pwd, 'Object_Can_NonCan_standard_run1');
        if ~isempty(dir(file(1,:)))==1
            mkdir ('Object_Can_NonCan_standard_run1_1')

            fid = fopen(file(1,:),'r');
            C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
            C = C{1};
            fclose(fid);

            onsets =[];
            onset = C(:,1);

            onset(contains(onset(:,:),'press')) = [];
            onset(contains(onset(:,:),'null')) = [];
            onset(contains(onset(:,:),'trigger')) = [];

            metal = onset(contains(onset(:,:),'_1.'));
            non_metal = onset(contains(onset(:,:),'_2.'));

            %2*2 onsets conditions aufgesplittet nach metal/non, Can/NonCan
            metal_C = metal(contains(metal(:,:),'_C_'));
            metal_N = metal(contains(metal(:,:),'_N_'));

            non_metal_C = non_metal(contains(non_metal(:,:),'_C_'));
            non_metal_N = non_metal(contains(non_metal(:,:),'_N_'));

            % Zeit rausschreiben
            % metal_C
            onset_metal_C = regexp(metal_C,'\d*','Match');

            for i=1:size(onset_metal_C, 1)
                time_onset_metal_C(i,1) = str2double(strcat(onset_metal_C{i}(3),'.', onset_metal_C{i}(4)));
            end
            save('time_onset_metal_C', 'time_onset_metal_C')
            movefile ('time_onset_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_1'))

            % metal N
            onset_metal_N = regexp(metal_N,'\d*','Match');

            for i=1:size(onset_metal_N, 1)
                time_onset_metal_N(i,1) = str2double(strcat(onset_metal_N{i}(3),'.', onset_metal_N{i}(4)));
            end
            save('time_onset_metal_N', 'time_onset_metal_N')
            movefile ('time_onset_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_1'))

            % Non_metal C
            onset_non_metal_C = regexp(non_metal_C,'\d*','Match');

            for i=1:size(onset_non_metal_C, 1)
                time_onset_non_metal_C(i,1) = str2double(strcat(onset_non_metal_C{i}(3),'.', onset_non_metal_C{i}(4)));
            end
            save('time_onset_non_metal_C', 'time_onset_non_metal_C')
            movefile ('time_onset_non_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_1'))

            % Non_metal N
            onset_non_metal_N = regexp(non_metal_N,'\d*','Match');

            for i=1:size(onset_non_metal_N, 1)
                time_onset_non_metal_N(i,1) = str2double(strcat(onset_non_metal_N{i}(3),'.', onset_non_metal_N{i}(4)));
            end
            save('time_onset_non_metal_N', 'time_onset_non_metal_N')
            movefile ('time_onset_non_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_1'))
        end

        if size (file,1) ==2
            if ~isempty(dir(file(2,:)))==1
                mkdir ('Object_Can_NonCan_standard_run1_2')

                fid = fopen(file(2,:),'r');
                C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
                C = C{1};
                fclose(fid);

                onsets =[];
                onset = C(:,1);

                onset(contains(onset(:,:),'press')) = [];
                onset(contains(onset(:,:),'null')) = [];
                onset(contains(onset(:,:),'trigger')) = [];

                metal = onset(contains(onset(:,:),'_1.'));
                non_metal = onset(contains(onset(:,:),'_2.'));

                 %2*2 onsets conditions aufgesplittet nach metal/non, Can/NonCan
                metal_C = metal(contains(metal(:,:),'_C_'));
                metal_N = metal(contains(metal(:,:),'_N_'));

                non_metal_C = non_metal(contains(non_metal(:,:),'_C_'));
                non_metal_N = non_metal(contains(non_metal(:,:),'_N_'));

                % Zeit rausschreiben
                % metal_C
                onset_metal_C = regexp(metal_C,'\d*','Match');

                for i=1:size(onset_metal_C, 1)
                    time_onset_metal_C(i,1) = str2double(strcat(onset_metal_C{i}(3),'.', onset_metal_C{i}(4)));
                end
                save('time_onset_metal_C', 'time_onset_metal_C')
                movefile ('time_onset_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_2'))

                % metal N
                onset_metal_N = regexp(metal_N,'\d*','Match');

                for i=1:size(onset_metal_N, 1)
                    time_onset_metal_N(i,1) = str2double(strcat(onset_metal_N{i}(3),'.', onset_metal_N{i}(4)));
                end
                save('time_onset_metal_N', 'time_onset_metal_N')
                movefile ('time_onset_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_2'))

                % Non_metal C
                onset_non_metal_C = regexp(non_metal_C,'\d*','Match');

                for i=1:size(onset_non_metal_C, 1)
                    time_onset_non_metal_C(i,1) = str2double(strcat(onset_non_metal_C{i}(3),'.', onset_non_metal_C{i}(4)));
                end
                save('time_onset_non_metal_C', 'time_onset_non_metal_C')
                movefile ('time_onset_non_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_2'))

                % Non_metal N
                onset_non_metal_N = regexp(non_metal_N,'\d*','Match');

                for i=1:size(onset_non_metal_N, 1)
                    time_onset_non_metal_N(i,1) = str2double(strcat(onset_non_metal_N{i}(3),'.', onset_non_metal_N{i}(4)));
                end
                save('time_onset_non_metal_N', 'time_onset_non_metal_N')
                movefile ('time_onset_non_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run1_2'))
            end
        end

       file = spm_select('List', pwd, 'Object_Can_NonCan_standard_run2');
        if ~isempty(dir(file(1,:)))==1
            mkdir ('Object_Can_NonCan_standard_run2_1')

            fid = fopen(file(1,:),'r');
            C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
            C = C{1};
            fclose(fid);

            onsets =[];
            onset = C(:,1);

            onset(contains(onset(:,:),'press')) = [];
            onset(contains(onset(:,:),'null')) = [];
            onset(contains(onset(:,:),'trigger')) = [];

            metal = onset(contains(onset(:,:),'_1.'));
            non_metal = onset(contains(onset(:,:),'_2.'));

            %2*2 onsets conditions aufgesplittet nach metal/non, Can/NonCan
            metal_C = metal(contains(metal(:,:),'_C_'));
            metal_N = metal(contains(metal(:,:),'_N_'));

            non_metal_C = non_metal(contains(non_metal(:,:),'_C_'));
            non_metal_N = non_metal(contains(non_metal(:,:),'_N_'));

            % Zeit rausschreiben
            % metal_C
            onset_metal_C = regexp(metal_C,'\d*','Match');

            for i=1:size(onset_metal_C, 1)
                time_onset_metal_C(i,1) = str2double(strcat(onset_metal_C{i}(3),'.', onset_metal_C{i}(4)));
            end
            save('time_onset_metal_C', 'time_onset_metal_C')
            movefile ('time_onset_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_1'))

            % metal N
            onset_metal_N = regexp(metal_N,'\d*','Match');

            for i=1:size(onset_metal_N, 1)
                time_onset_metal_N(i,1) = str2double(strcat(onset_metal_N{i}(3),'.', onset_metal_N{i}(4)));
            end
            save('time_onset_metal_N', 'time_onset_metal_N')
            movefile ('time_onset_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_1'))

            % Non_metal C
            onset_non_metal_C = regexp(non_metal_C,'\d*','Match');

            for i=1:size(onset_non_metal_C, 1)
                time_onset_non_metal_C(i,1) = str2double(strcat(onset_non_metal_C{i}(3),'.', onset_non_metal_C{i}(4)));
            end
            save('time_onset_non_metal_C', 'time_onset_non_metal_C')
            movefile ('time_onset_non_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_1'))

            % Non_metal N
            onset_non_metal_N = regexp(non_metal_N,'\d*','Match');

            for i=1:size(onset_non_metal_N, 1)
                time_onset_non_metal_N(i,1) = str2double(strcat(onset_non_metal_N{i}(3),'.', onset_non_metal_N{i}(4)));
            end
            save('time_onset_non_metal_N', 'time_onset_non_metal_N')
            movefile ('time_onset_non_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_1'))

        end

        if size(file,1) ==2
            if ~isempty(dir(file(2,:)))==1
                mkdir ('Object_Can_NonCan_standard_run2_2')

                fid = fopen(file(2,:),'r');
                C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
                C = C{1};
                fclose(fid);

                onsets =[];
                onset = C(:,1);

                onset(contains(onset(:,:),'press')) = [];
                onset(contains(onset(:,:),'null')) = [];
                onset(contains(onset(:,:),'trigger')) = [];

                metal = onset(contains(onset(:,:),'_1.'));
                non_metal = onset(contains(onset(:,:),'_2.'));

                %2*2 onsets conditions aufgesplittet nach metal/non, Can/NonCan
                metal_C = metal(contains(metal(:,:),'_C_'));
                metal_N = metal(contains(metal(:,:),'_N_'));

                non_metal_C = non_metal(contains(non_metal(:,:),'_C_'));
                non_metal_N = non_metal(contains(non_metal(:,:),'_N_'));

                % Zeit rausschreiben
                % metal_C
                onset_metal_C = regexp(metal_C,'\d*','Match');

                for i=1:size(onset_metal_C, 1)
                    time_onset_metal_C(i,1) = str2double(strcat(onset_metal_C{i}(3),'.', onset_metal_C{i}(4)));
                end
                save('time_onset_metal_C', 'time_onset_metal_C')
                movefile ('time_onset_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_2'))

                % metal N
                onset_metal_N = regexp(metal_N,'\d*','Match');

                for i=1:size(onset_metal_N, 1)
                    time_onset_metal_N(i,1) = str2double(strcat(onset_metal_N{i}(3),'.', onset_metal_N{i}(4)));
                end
                save('time_onset_metal_N', 'time_onset_metal_N')
                movefile ('time_onset_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_2'))

                % Non_metal C
                onset_non_metal_C = regexp(non_metal_C,'\d*','Match');

                for i=1:size(onset_non_metal_C, 1)
                    time_onset_non_metal_C(i,1) = str2double(strcat(onset_non_metal_C{i}(3),'.', onset_non_metal_C{i}(4)));
                end
                save('time_onset_non_metal_C', 'time_onset_non_metal_C')
                movefile ('time_onset_non_metal_C.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_2'))

                % Non_metal N
                onset_non_metal_N = regexp(non_metal_N,'\d*','Match');

                for i=1:size(onset_non_metal_N, 1)
                    time_onset_non_metal_N(i,1) = str2double(strcat(onset_non_metal_N{i}(3),'.', onset_non_metal_N{i}(4)));
                end
                save('time_onset_non_metal_N','time_onset_non_metal_N')
                movefile ('time_onset_non_metal_N.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Object_Can_NonCan_standard_run2_2'))
            end
        end
    end
        
end