% script used to configure the parameters for the design and analysis

% %% add the libraries path
% currentFolder = pwd;
% data_analysis_folder = strcat(pwd,'\data_analysis');
% KinematicLib_folder =  strcat(pwd,'\KinematicLib');
% addpath(genpath(data_analysis_folder));
% addpath(genpath(KinematicLib_folder));
global parentFolder
%% add the libraries path
currentFolder = pwd;
parentFolder = erase(currentFolder,'\scripts');
data_analysis_folder = strcat(parentFolder,'\data_analysis');
KinematicLib_folder =  strcat(parentFolder,'\KinematicLib');
addpath(genpath(data_analysis_folder));
addpath(genpath(KinematicLib_folder));

%% mechanism description
version = 'neck_4_joints';                                                 % mechanism version
Tw = eye(4);                                                               % world frame

%% grafic configuration
display_graph = true;                                                      % set to false to hide the plot of the results
set(groot, 'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize',14);
set(groot, 'defaultLegendFontSize',14)
set(groot, 'defaultFigureRenderer', 'painters');
set(groot, 'defaultLineLineWidth',1.2);

color = [0      0.4470 0.7410;
         0.8500 0.3250 0.0980;
         0.9290 0.6940 0.1250;
         0.4940 0.1840 0.5560;
         0.4660 0.6740 0.1880;
         0.3010 0.7450 0.9330];