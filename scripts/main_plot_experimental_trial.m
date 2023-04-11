close all;
clear variables;
clc;

%% load configuration parameters
config;

%% set the analysis parameters
subject_num = 6;                                                           % select the subject to analyse
trial_num = 5;                                                             % select the trial to analyse
[dataset] = create_dataset();                                              % load the dataset
data = dataset.subject{subject_num}.session{1}.trial{trial_num}.data_marker;

% compute the offset to align the initial frame of the head with the torso frame
data_mean = data.Variables;
data_mean = mean(data_mean(1:15,:));
data_mean_table = array2table(data_mean,'VariableNames',...
    data.Properties.VariableNames);
[frames_0, origin_0] = find_frames(data_mean_table(1,:),Tw);
p0 = frames_0{2}*([0;1;0].*(frames_0{2}'*(origin_0(:,1)-origin_0(:,2))));
R0 = frames_0{2}*frames_0{1}';
T0 = [R0,p0;zeros(1,3),1];

% plot frames and markers
view_plot = [40,20];
f = figure;                                                 
step = 10;                                                                 % number of data samples to skip
for i = 1:step:data.Frame(end)
    clf
    plot_markers(data(i,:),T0,view_plot);
    drawnow;
end


