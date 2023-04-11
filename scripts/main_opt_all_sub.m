clear variables;
close all;
clc;

%% load configuration parameters
config;

%% optimisation parameters
n_param = 7;                                % number of geometrical parameters
% optimisation matrices
Ai = zeros(3,n_param);
A = zeros(n_param);
b = zeros(n_param,1);

sub_order = [1 6 3 5 2 4];
n_sub = length(sub_order);                  % number of subjects
n_design = 6;                               % number of optimal design



%% dataset parameters
divide_dataset_settings.ratio = 0.75;       
divide_dataset_settings.seed = 1;
divide_dataset_settings.random = false;
n_trial = 5;                            


%% optimisation algorithm
design = 0;
q_tot = [];
p_tot = [];
res = cell(n_design,1);
% loop over the subjects
for sub = sub_order
    
    path_rel = strcat('data_analysis\data_for_optimization\subject_0',...
        num2str(sub),'\session_01\trial_');
    % concatenate the data of each trial
    for trial = 1:n_trial
        path_trial = strcat(path_rel,num2str(trial));
        path_q = fullfile(parentFolder,path_trial,'q.mat');
        path_p = fullfile(parentFolder,path_trial,'p_TCP.mat');
        load(path_q);
        load(path_p);
        q_tot = [q_tot;q];
        p_tot = [p_tot,p];
    end

    design = design+1;
    [qo,qv,po,pv] = divide_dataset(q_tot,p_tot,...
        divide_dataset_settings);                                          % split the dataset in the optimisationa and validation sets
    n_sample_o = length(qo);

    % optimisation procedure
    for i = 1:n_sample_o
        c1 = cos(qo(i,1));
        s1 = sin(qo(i,1));
        c2 = cos(qo(i,2));
        s2 = sin(qo(i,2));
        c3 = cos(qo(i,3));
        s3 = sin(qo(i,3));
        c4 = cos(qo(i,4));
        s4 = sin(qo(i,4));

        Ai(1,1) = 1;
        Ai(1,2) = s1*s2;
        Ai(1,3) = c1*s3 +c3*s1*s2;
        Ai(1,4) = c1*c3*c4 -c1*s3*s4 -c3*s1*s2*s4 -c4*s1*s2*s3;
        Ai(1,6) = c1;
        Ai(1,7) = c1*c3*s4 +c1*c4*s3 +c3*c4*s1*s2 -s1*s2*s3*s4;
        Ai(2,2) = -c1*s2;
        Ai(2,3) = s1*s3 - c1*c3*s2;
        Ai(2,4) = s1*c3*c4 -s1*s3*s4 +c3*c1*s2*s4 +c4*c1*s2*s3;
        Ai(2,6) = s1;
        Ai(2,7) = s1*c3*s4 +s1*c4*s3 -c3*c4*c1*s2 +c1*s2*s3*s4;
        Ai(3,2) = c2;
        Ai(3,3) = c2*c3;
        Ai(3,4) = -c2*c3*s4 -c2*c4*s3;
        Ai(3,5) = 1;
        Ai(3,7) = c2*c3*c4 -c2*s3*s4;

        A = A+ Ai'*Ai;
        b = b + Ai'*po(:,i);
    end
    beta = A\b;
    parameters.a1 	 = 	beta(1);
    parameters.a3 	 = 	beta(2);
    parameters.a4 	 =  beta(3);
    parameters.a_tcp = 	beta(4);
    parameters.d1 	 = 	beta(5);
    parameters.d2 	 = 	beta(6);
    parameters.d_tcp = 	beta(7);

    % validation procedure
    n_sample_v = length(qv);
    err = zeros(n_sample_v,1);
    err_rel = zeros(n_sample_v,1);

    for i = 1:n_sample_v
        dhp = DH_par(version,qv(i,:)',parameters);
        [p_tcp_trial_tmp,~] = DirectKinematic(dhp,Tw);
        p_tcp_trial = p_tcp_trial_tmp(1:3,end);
        err(i) = norm(pv(:,i) - p_tcp_trial,2);
        err_rel(i) = norm(pv(:,i) - p_tcp_trial,2)/norm(p_tcp_trial);
    end

    % compute absolute performance indicators
    e_mean = mean(err);
    e_std = std(err);
    e_median = median(err);

    % compute relative performance indicators
    e_mean_rel = mean(err_rel);
    e_std_rel = std(err_rel);
    e_median_rel = median(err_rel);

    % save results
    res{design}.err = err;
    res{design}.err_rel = err_rel;
    res{design}.beta = beta;
    res{design}.e_mean = e_mean;
    res{design}.e_std = e_std;
    res{design}.e_median = e_median;
    res{design}.e_mean_rel = e_mean_rel;
    res{design}.e_std_rel = e_std_rel;
    res{design}.e_median_rel = e_median_rel;
    res{design}.opt_par = parameters;

    % initialise variables for the next iteration
    q_tot = [];
    p_tot = [];      

    % display performance indicators
    disp(strcat("Results design ",num2str(design),":"))
    disp("Absolute error")
    disp(strcat("mean: ",num2str(1000*e_mean)));
    disp(strcat("std: ",num2str(1000*e_std)));
    disp(strcat("median: ",num2str(1000*e_median)));
    disp("Relative error")
    disp(strcat("mean: ",num2str(100*e_mean_rel)));
    disp(strcat("std: ",num2str(100*e_std_rel)));
    disp(strcat("median: ",num2str(100*e_median_rel)));
    disp("------------------");

    % plot validation results
    if display_graph
        figure;
        title_name = strcat("Subject ID0", num2str(sub), " Absolute Error");
        histogram(1000*err,'BinWidth',2.5,'Normalization','probability');
        xlabel("$e^o$[mm]",'Interpreter','latex');
        ylabel("Relative Probability",'Interpreter','latex');
        ylim([0,0.30])
        grid on;
        title(title_name);

        figure;
        title_name = strcat("Subject ID0", num2str(sub), " Relative Error");
        histogram(err_rel,'BinWidth',0.0125,'Normalization','probability');
        xlabel("$e^o_r$[\%]",'Interpreter','latex');
        ylabel("Relative Probability",'Interpreter','latex');
        ylim([0,0.35])
        grid on;
        title(title_name);

    end
end


%% plot subject comparison histogram
if display_graph
    f = figure;
    axes1 = axes('Parent',f);
    hold(axes1,'on');

    for i = 1:n_design
        histogram2(res{i}.err_rel,i*ones(size(res{i}.err_rel)),...
            'BinWidth',[0.0125 0.25],'Normalization','probability');
        hold on;
    end
    box(axes1,'on');
    grid(axes1,'on');
    axis(axes1,'tight');
    set(axes1,'YTick',[1 2 3 4 5 6],'YTickLabel',...
        {'01','06','03','05','02','04'});
    xlabel('$e^o_r$[\%]', 'interpreter','latex')
    ylabel('ID', 'interpreter','latex')
    zlabel('Relative Probability')
    view(30,10)
    legend('ID 01','ID 06','ID 03','ID 05','ID 02','ID 04','Location','NorthEast');
    title_name = "Subjects' Relative Errors Comparison";
    title(title_name);
end