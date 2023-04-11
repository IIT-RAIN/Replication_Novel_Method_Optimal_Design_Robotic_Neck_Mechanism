close all;
clear variables;
clc;


%% load configuration parameters
config;

%% set the dataset parameters
n_sub = 6;                                                                 % number of subjects
n_trial = 5;                                                               % number of trials

%% preprocessing
mkdir('data_for_optimization');                                            % folder where the data are saved
for k = 1:n_sub
    folder_name = strcat("data_for_optimization\subject_0",num2str(k),...
        "\session_01");   
    for j = 1:n_trial
        folder_name_tot = strcat(folder_name,"\trial_",num2str(j));
        mkdir(folder_name_tot);
        trial_num = j;
        [dataset] = create_dataset();
        data = dataset.subject{k}.session{1}.trial{trial_num}.data_marker;
        
        % compute the offset to align the initial frame of the head with the torso frame
        data_mean = data.Variables;
        data_mean = mean(data_mean(1:15,:));
        data_mean_table = array2table(data_mean,'VariableNames',...
            data.Properties.VariableNames);
        [frames_0, origin_0] = find_frames(data_mean_table(1,:),Tw);
        p0 = frames_0{2}*([0;1;0].*(frames_0{2}'*(origin_0(:,1)-origin_0(:,2))));
        R0 = frames_0{2}*frames_0{1}';
        T0 = [R0,p0;zeros(1,3),1];
        
        % initialise the variables
        q = zeros(data.Frame(end),4);
        p = zeros(3,data.Frame(end));
        R = cell(1,data.Frame(end));
        
        % variables generation
        for i = 1:1:data.Frame(end)
            [frames,origins] = find_frames(data(i,:),T0);
            p(:,i) = frames{2}'*(origins(:,1) - origins(:,2))*10^(-3);
            R{i} = frames{2}'*frames{1};
            [rot_z1(i),rot_x2(i),rot_y3(i)] = find_angles_TB_ZXY(frames);
            q(i,1) = rot_z1(i);
            q(i,2) = rot_x2(i);
            if rot_y3(i) - rot_y3(1) >= 0
                q(i,3) = rot_y3(i);
                q(i,4) = rot_y3(1);
            else
                q(i,3) = rot_y3(1);
                q(i,4) = rot_y3(i);
            end 
        end

        q_name = strcat(folder_name_tot,'\q.mat');
        p_name = strcat(folder_name_tot,'\p_TCP.mat');
        R_name = strcat(folder_name_tot,'\R_TCP.mat');

        save(q_name,'q')
        save(p_name,'p')
        save(R_name,'R')
    end
end