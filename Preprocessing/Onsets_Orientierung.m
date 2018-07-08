C_Can=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\C_Canonisch');
C_Can = {C_Can(:).name}';
C_Can(ismember(C_Can,{'.','..'})) = [];
C_Rot=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\C_Rotiert');
C_Rot = {C_Rot(:).name}';
C_Rot(ismember(C_Rot,{'.','..'})) = [];
N_Rot_Tiefe=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\N_Rotation Raumtiefe');
N_Rot_Tiefe = {N_Rot_Tiefe(:).name}';
N_Rot_Tiefe(ismember(N_Rot_Tiefe,{'.','..'})) = [];
N_Rot_Bild=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\N_Seitlich gekippt');
N_Rot_Bild = {N_Rot_Bild(:).name}';
N_Rot_Bild(ismember(N_Rot_Bild,{'.','..'})) = [];
N_Rot_Tiefe_kipp=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\N_Rotation Raumtiefe_gekippt');
N_Rot_Tiefe_kipp = {N_Rot_Tiefe_kipp(:).name}';
N_Rot_Tiefe_kipp(ismember(N_Rot_Tiefe_kipp,{'.','..'})) = [];
N_Seite=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\N_Seitenansicht');
N_Seite = {N_Seite(:).name}';
N_Seite(ismember(N_Seite,{'.','..'})) = [];
N_Oben=dir('E:\Cloud\fMRI OBJ_Gestalt Nifti\Stimuli_Gruppiert\N_von_oben');
N_Oben = {N_Oben(:).name}';
N_Oben(ismember(N_Oben,{'.','..'})) = [];

cd 'E:\fmrt\fMRI OBJ_Gestalt Nifti'
cf = pwd;
subjects = ['Test';'VP01';'VP02'; 'VP03'];

for g = 1:size(subjects,1)
    VP_name = subjects(g,:);
    k=1;
    cd(fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name))
    file = spm_select('List', pwd, 'Object_Can_NonCan_standard_run1');
    if ~isempty(dir(file(1,:)))==1
    
        mkdir('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_Behav_ET\behavioral\Test\Orientierungen','Object_Can_NonCan_standard_run1_1')

        fid = fopen(file(1,:),'r');
        C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
        C = C{1};
        fclose(fid);
        onsets =[];
        onset = C(:,1);
        onset_N_Oben = onset(contains(onset(:,:),N_Oben));
        onset_N_Rot_Tiefe_kipp = onset(contains(onset(:,:),N_Rot_Tiefe_kipp));
        onset_C_Can = onset(contains(onset(:,:),C_Can));
        onset_N_Rot_Bild = onset(contains(onset(:,:),N_Rot_Bild));
        onset_N_Seite = onset(contains(onset(:,:),N_Seite));
        onset_C_Rot = onset(contains(onset(:,:),C_Rot));
        onset_N_Rot_Tiefe = onset(contains(onset(:,:),N_Rot_Tiefe));


        % Zeit rausschreiben
            % N_Oben
            N_Oben_onset = regexp(onset_N_Oben,'\d*','Match');

            for i=1:size(N_Oben_onset, 1)
                time_onset_N_Oben(i,1) = str2double(strcat(N_Oben_onset{i}(3),'.', N_Oben_onset{i}(4)));
            end
            save('time_onset_N_Oben', 'time_onset_N_Oben')
            movefile ('time_onset_N_Oben.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))

           % N_Rot_Tiefe_kipp
            N_Rot_Tiefe_kipp_onset = regexp(onset_N_Rot_Tiefe_kipp,'\d*','Match');

            for i=1:size(N_Rot_Tiefe_kipp_onset, 1)
                time_onset_N_Rot_Tiefe_kipp(i,1) = str2double(strcat(N_Rot_Tiefe_kipp_onset{i}(3),'.', N_Rot_Tiefe_kipp_onset{i}(4)));
            end
            save('time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Rot_Tiefe_kipp')
            movefile ('time_onset_N_Rot_Tiefe_kipp.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))


            % C_Can
            C_Can_onset = regexp(onset_C_Can,'\d*','Match');

            for i=1:size(C_Can_onset, 1)
                time_onset_C_Can(i,1) = str2double(strcat(C_Can_onset{i}(3),'.', C_Can_onset{i}(4)));
            end
            save('time_onset_C_Can', 'time_onset_C_Can')
            movefile ('time_onset_C_Can.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))

            % N_Rot_Bild
            N_Rot_Bild_onset = regexp(onset_N_Rot_Bild,'\d*','Match');

            for i=1:size(N_Rot_Bild_onset, 1)
                time_onset_N_Rot_Bild(i,1) = str2double(strcat(N_Rot_Bild_onset{i}(3),'.', N_Rot_Bild_onset{i}(4)));
            end
            save('time_onset_N_Rot_Bild', 'time_onset_N_Rot_Bild')
            movefile ('time_onset_N_Rot_Bild.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))


            % N_Seite
            N_Seite_onset = regexp(onset_N_Seite,'\d*','Match');

            for i=1:size(N_Seite_onset, 1)
                time_onset_N_Seite(i,1) = str2double(strcat(N_Seite_onset{i}(3),'.', N_Seite_onset{i}(4)));
            end
            save('time_onset_N_Seite', 'time_onset_N_Seite')
            movefile ('time_onset_N_Seite.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))

            % C_Rot
            C_Rot_onset = regexp(onset_C_Rot,'\d*','Match');

            for i=1:size(C_Rot_onset, 1)
                time_onset_C_Rot(i,1) = str2double(strcat(C_Rot_onset{i}(3),'.', C_Rot_onset{i}(4)));
            end
            save('time_onset_C_Rot', 'time_onset_C_Rot')
            movefile ('time_onset_C_Rot.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))

            % N_Rot_Tiefe
            N_Rot_Tiefe_onset = regexp(onset_N_Rot_Tiefe,'\d*','Match');

            for i=1:size(N_Rot_Tiefe_onset, 1)
                time_onset_N_Rot_Tiefe(i,1) = str2double(strcat(N_Rot_Tiefe_onset{i}(3),'.', N_Rot_Tiefe_onset{i}(4)));
            end
            save('time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe')
            movefile ('time_onset_N_Rot_Tiefe.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_1'))
        
            clear('onsets', 'onset', 'onset_C_Can', 'onset_C_Rot', 'onset_N_Oben', 'onset_N_Rot_Bild', 'onset_N_Rot_Tiefe', 'onset_N_Rot_Tiefe_kipp', 'onset_N_Seite')
            clear('time_onset_C_Can', 'time_onset_C_Rot', 'time_onset_N_Oben', 'time_onset_N_Rot_Bild', 'time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Seite')
            clear('N_Oben_onset', 'N_Rot_Bild_onset', 'N_Rot_Tiefe_kipp_onset', 'N_Rot_Tiefe_onset', 'N_Seite_onset', 'C_Can_onset', 'C_Rot_onset')
    end
    
    if size (file,1) ==2
        if ~isempty(dir(file(2,:)))==1
            mkdir ('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_Behav_ET\behavioral\Test\Orientierungen', 'Object_Can_NonCan_standard_run1_2')
            fid = fopen(file(2,:),'r');
            C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
            C = C{1};
            fclose(fid);
            onsets =[];
            onset = C(:,1);
            onset_N_Oben = onset(contains(onset(:,:),N_Oben));
            onset_N_Rot_Tiefe_kipp = onset(contains(onset(:,:),N_Rot_Tiefe_kipp));
            onset_C_Can = onset(contains(onset(:,:),C_Can));
            onset_N_Rot_Bild = onset(contains(onset(:,:),N_Rot_Bild));
            onset_N_Seite = onset(contains(onset(:,:),N_Seite));
            onset_C_Rot = onset(contains(onset(:,:),C_Rot));
            onset_N_Rot_Tiefe = onset(contains(onset(:,:),N_Rot_Tiefe));


            % Zeit rausschreiben
                % N_Oben
                N_Oben_onset = regexp(onset_N_Oben,'\d*','Match');

                for i=1:size(N_Oben_onset, 1)
                    time_onset_N_Oben(i,1) = str2double(strcat(N_Oben_onset{i}(3),'.', N_Oben_onset{i}(4)));
                end
                save('time_onset_N_Oben', 'time_onset_N_Oben')
                movefile ('time_onset_N_Oben.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))

               % N_Rot_Tiefe_kipp
                N_Rot_Tiefe_kipp_onset = regexp(onset_N_Rot_Tiefe_kipp,'\d*','Match');

                for i=1:size(N_Rot_Tiefe_kipp_onset, 1)
                    time_onset_N_Rot_Tiefe_kipp(i,1) = str2double(strcat(N_Rot_Tiefe_kipp_onset{i}(3),'.', N_Rot_Tiefe_kipp_onset{i}(4)));
                end
                save('time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Rot_Tiefe_kipp')
                movefile ('time_onset_N_Rot_Tiefe_kipp.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))


                % C_Can
                C_Can_onset = regexp(onset_C_Can,'\d*','Match');

                for i=1:size(C_Can_onset, 1)
                    time_onset_C_Can(i,1) = str2double(strcat(C_Can_onset{i}(3),'.', C_Can_onset{i}(4)));
                end
                save('time_onset_C_Can', 'time_onset_C_Can')
                movefile ('time_onset_C_Can.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))

                % N_Rot_Bild
                N_Rot_Bild_onset = regexp(onset_N_Rot_Bild,'\d*','Match');

                for i=1:size(N_Rot_Bild_onset, 1)
                    time_onset_N_Rot_Bild(i,1) = str2double(strcat(N_Rot_Bild_onset{i}(3),'.', N_Rot_Bild_onset{i}(4)));
                end
                save('time_onset_N_Rot_Bild', 'time_onset_N_Rot_Bild')
                movefile ('time_onset_N_Rot_Bild.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))


                % N_Seite
                N_Seite_onset = regexp(onset_N_Seite,'\d*','Match');

                for i=1:size(N_Seite_onset, 1)
                    time_onset_N_Seite(i,1) = str2double(strcat(N_Seite_onset{i}(3),'.', N_Seite_onset{i}(4)));
                end
                save('time_onset_N_Seite', 'time_onset_N_Seite')
                movefile ('time_onset_N_Seite.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))

                % C_Rot
                C_Rot_onset = regexp(onset_C_Rot,'\d*','Match');

                for i=1:size(C_Rot_onset, 1)
                    time_onset_C_Rot(i,1) = str2double(strcat(C_Rot_onset{i}(3),'.', C_Rot_onset{i}(4)));
                end
                save('time_onset_C_Rot', 'time_onset_C_Rot')
                movefile ('time_onset_C_Rot.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))

                % N_Rot_Tiefe
                N_Rot_Tiefe_onset = regexp(onset_N_Rot_Tiefe,'\d*','Match');

                for i=1:size(N_Rot_Tiefe_onset, 1)
                    time_onset_N_Rot_Tiefe(i,1) = str2double(strcat(N_Rot_Tiefe_onset{i}(3),'.', N_Rot_Tiefe_onset{i}(4)));
                end
                save('time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe')
                movefile ('time_onset_N_Rot_Tiefe.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run1_2'))
            
                clear('onsets', 'onset', 'onset_C_Can', 'onset_C_Rot', 'onset_N_Oben', 'onset_N_Rot_Bild', 'onset_N_Rot_Tiefe', 'onset_N_Rot_Tiefe_kipp', 'onset_N_Seite')
                clear('time_onset_C_Can', 'time_onset_C_Rot', 'time_onset_N_Oben', 'time_onset_N_Rot_Bild', 'time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Seite')
                clear('N_Oben_onset', 'N_Rot_Bild_onset', 'N_Rot_Tiefe_kipp_onset', 'N_Rot_Tiefe_onset', 'N_Seite_onset', 'C_Can_onset', 'C_Rot_onset')
        end
    end
    
        file = spm_select('List', pwd, 'Object_Can_NonCan_standard_run2');
        if ~isempty(dir(file(1,:)))==1
            mkdir ('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_Behav_ET\behavioral\Test\Orientierungen', 'Object_Can_NonCan_standard_run2_1')

            fid = fopen(file(1,:),'r');
            C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
            C = C{1};
            fclose(fid);
            onsets =[];
            onset = C(:,1);
            onset_N_Oben = onset(contains(onset(:,:),N_Oben));
            onset_N_Rot_Tiefe_kipp = onset(contains(onset(:,:),N_Rot_Tiefe_kipp));
            onset_C_Can = onset(contains(onset(:,:),C_Can));
            onset_N_Rot_Bild = onset(contains(onset(:,:),N_Rot_Bild));
            onset_N_Seite = onset(contains(onset(:,:),N_Seite));
            onset_C_Rot = onset(contains(onset(:,:),C_Rot));
            onset_N_Rot_Tiefe = onset(contains(onset(:,:),N_Rot_Tiefe));


            % Zeit rausschreiben
                % N_Oben
                N_Oben_onset = regexp(onset_N_Oben,'\d*','Match');

                for i=1:size(N_Oben_onset, 1)
                    time_onset_N_Oben(i,1) = str2double(strcat(N_Oben_onset{i}(3),'.', N_Oben_onset{i}(4)));
                end
                save('time_onset_N_Oben', 'time_onset_N_Oben')
                movefile ('time_onset_N_Oben.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))

               % N_Rot_Tiefe_kipp
                N_Rot_Tiefe_kipp_onset = regexp(onset_N_Rot_Tiefe_kipp,'\d*','Match');

                for i=1:size(N_Rot_Tiefe_kipp_onset, 1)
                    time_onset_N_Rot_Tiefe_kipp(i,1) = str2double(strcat(N_Rot_Tiefe_kipp_onset{i}(3),'.', N_Rot_Tiefe_kipp_onset{i}(4)));
                end
                save('time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Rot_Tiefe_kipp')
                movefile ('time_onset_N_Rot_Tiefe_kipp.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))


                % C_Can
                C_Can_onset = regexp(onset_C_Can,'\d*','Match');

                for i=1:size(C_Can_onset, 1)
                    time_onset_C_Can(i,1) = str2double(strcat(C_Can_onset{i}(3),'.', C_Can_onset{i}(4)));
                end
                save('time_onset_C_Can', 'time_onset_C_Can')
                movefile ('time_onset_C_Can.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))

                % N_Rot_Bild
                N_Rot_Bild_onset = regexp(onset_N_Rot_Bild,'\d*','Match');

                for i=1:size(N_Rot_Bild_onset, 1)
                    time_onset_N_Rot_Bild(i,1) = str2double(strcat(N_Rot_Bild_onset{i}(3),'.', N_Rot_Bild_onset{i}(4)));
                end
                save('time_onset_N_Rot_Bild', 'time_onset_N_Rot_Bild')
                movefile ('time_onset_N_Rot_Bild.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))


                % N_Seite
                N_Seite_onset = regexp(onset_N_Seite,'\d*','Match');

                for i=1:size(N_Seite_onset, 1)
                    time_onset_N_Seite(i,1) = str2double(strcat(N_Seite_onset{i}(3),'.', N_Seite_onset{i}(4)));
                end
                save('time_onset_N_Seite', 'time_onset_N_Seite')
                movefile ('time_onset_N_Seite.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))

                % C_Rot
                C_Rot_onset = regexp(onset_C_Rot,'\d*','Match');

                for i=1:size(C_Rot_onset, 1)
                    time_onset_C_Rot(i,1) = str2double(strcat(C_Rot_onset{i}(3),'.', C_Rot_onset{i}(4)));
                end
                save('time_onset_C_Rot', 'time_onset_C_Rot')
                movefile ('time_onset_C_Rot.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))

                % N_Rot_Tiefe
                N_Rot_Tiefe_onset = regexp(onset_N_Rot_Tiefe,'\d*','Match');

                for i=1:size(N_Rot_Tiefe_onset, 1)
                    time_onset_N_Rot_Tiefe(i,1) = str2double(strcat(N_Rot_Tiefe_onset{i}(3),'.', N_Rot_Tiefe_onset{i}(4)));
                end
                save('time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe')
                movefile ('time_onset_N_Rot_Tiefe.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_1'))
            
                clear('onsets', 'onset', 'onset_C_Can', 'onset_C_Rot', 'onset_N_Oben', 'onset_N_Rot_Bild', 'onset_N_Rot_Tiefe', 'onset_N_Rot_Tiefe_kipp', 'onset_N_Seite')
                clear('time_onset_C_Can', 'time_onset_C_Rot', 'time_onset_N_Oben', 'time_onset_N_Rot_Bild', 'time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Seite')
                clear('N_Oben_onset', 'N_Rot_Bild_onset', 'N_Rot_Tiefe_kipp_onset', 'N_Rot_Tiefe_onset', 'N_Seite_onset', 'C_Can_onset', 'C_Rot_onset')
        end    
        
         if size(file,1) ==2
            if ~isempty(dir(file(2,:)))==1
                mkdir ('E:\fmrt\fMRI OBJ_Gestalt Nifti\Object_Behav_ET\behavioral\Test\Orientierungen', 'Object_Can_NonCan_standard_run2_2')

                fid = fopen(file(2,:),'r');
                C = textscan(fid, repmat('%s',1,10), 'delimiter',';', 'CollectOutput',true);
                C = C{1};
                fclose(fid);
                onsets =[];
                onset = C(:,1);
                onset_N_Oben = onset(contains(onset(:,:),N_Oben));
                onset_N_Rot_Tiefe_kipp = onset(contains(onset(:,:),N_Rot_Tiefe_kipp));
                onset_C_Can = onset(contains(onset(:,:),C_Can));
                onset_N_Rot_Bild = onset(contains(onset(:,:),N_Rot_Bild));
                onset_N_Seite = onset(contains(onset(:,:),N_Seite));
                onset_C_Rot = onset(contains(onset(:,:),C_Rot));
                onset_N_Rot_Tiefe = onset(contains(onset(:,:),N_Rot_Tiefe));


                % Zeit rausschreiben
                    % N_Oben
                    N_Oben_onset = regexp(onset_N_Oben,'\d*','Match');

                    for i=1:size(N_Oben_onset, 1)
                        time_onset_N_Oben(i,1) = str2double(strcat(N_Oben_onset{i}(3),'.', N_Oben_onset{i}(4)));
                    end
                    save('time_onset_N_Oben', 'time_onset_N_Oben')
                    movefile ('time_onset_N_Oben.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))

                   % N_Rot_Tiefe_kipp
                    N_Rot_Tiefe_kipp_onset = regexp(onset_N_Rot_Tiefe_kipp,'\d*','Match');

                    for i=1:size(N_Rot_Tiefe_kipp_onset, 1)
                        time_onset_N_Rot_Tiefe_kipp(i,1) = str2double(strcat(N_Rot_Tiefe_kipp_onset{i}(3),'.', N_Rot_Tiefe_kipp_onset{i}(4)));
                    end
                    save('time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Rot_Tiefe_kipp')
                    movefile ('time_onset_N_Rot_Tiefe_kipp.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))


                    % C_Can
                    C_Can_onset = regexp(onset_C_Can,'\d*','Match');

                    for i=1:size(C_Can_onset, 1)
                        time_onset_C_Can(i,1) = str2double(strcat(C_Can_onset{i}(3),'.', C_Can_onset{i}(4)));
                    end
                    save('time_onset_C_Can', 'time_onset_C_Can')
                    movefile ('time_onset_C_Can.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))

                    % N_Rot_Bild
                    N_Rot_Bild_onset = regexp(onset_N_Rot_Bild,'\d*','Match');

                    for i=1:size(N_Rot_Bild_onset, 1)
                        time_onset_N_Rot_Bild(i,1) = str2double(strcat(N_Rot_Bild_onset{i}(3),'.', N_Rot_Bild_onset{i}(4)));
                    end
                    save('time_onset_N_Rot_Bild', 'time_onset_N_Rot_Bild')
                    movefile ('time_onset_N_Rot_Bild.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))


                    % N_Seite
                    N_Seite_onset = regexp(onset_N_Seite,'\d*','Match');

                    for i=1:size(N_Seite_onset, 1)
                        time_onset_N_Seite(i,1) = str2double(strcat(N_Seite_onset{i}(3),'.', N_Seite_onset{i}(4)));
                    end
                    save('time_onset_N_Seite', 'time_onset_N_Seite')
                    movefile ('time_onset_N_Seite.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))

                    % C_Rot
                    C_Rot_onset = regexp(onset_C_Rot,'\d*','Match');

                    for i=1:size(C_Rot_onset, 1)
                        time_onset_C_Rot(i,1) = str2double(strcat(C_Rot_onset{i}(3),'.', C_Rot_onset{i}(4)));
                    end
                    save('time_onset_C_Rot', 'time_onset_C_Rot')
                    movefile ('time_onset_C_Rot.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))

                    % N_Rot_Tiefe
                    N_Rot_Tiefe_onset = regexp(onset_N_Rot_Tiefe,'\d*','Match');

                    for i=1:size(N_Rot_Tiefe_onset, 1)
                        time_onset_N_Rot_Tiefe(i,1) = str2double(strcat(N_Rot_Tiefe_onset{i}(3),'.', N_Rot_Tiefe_onset{i}(4)));
                    end
                    save('time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe')
                    movefile ('time_onset_N_Rot_Tiefe.mat', fullfile(cf, 'Object_Behav_ET\behavioral', '\', VP_name, 'Orientierungen\Object_Can_NonCan_standard_run2_2'))

                    clear('onsets', 'onset', 'onset_C_Can', 'onset_C_Rot', 'onset_N_Oben', 'onset_N_Rot_Bild', 'onset_N_Rot_Tiefe', 'onset_N_Rot_Tiefe_kipp', 'onset_N_Seite')
                    clear('time_onset_C_Can', 'time_onset_C_Rot', 'time_onset_N_Oben', 'time_onset_N_Rot_Bild', 'time_onset_N_Rot_Tiefe', 'time_onset_N_Rot_Tiefe_kipp', 'time_onset_N_Seite')
                    clear('N_Oben_onset', 'N_Rot_Bild_onset', 'N_Rot_Tiefe_kipp_onset', 'N_Rot_Tiefe_onset', 'N_Seite_onset', 'C_Can_onset', 'C_Rot_onset')
            end 
         end
    
end
