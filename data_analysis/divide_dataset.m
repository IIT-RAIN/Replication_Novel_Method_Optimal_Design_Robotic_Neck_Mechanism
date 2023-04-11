function [qo,qv,po,pv] = divide_dataset(qt,pt,settings)
%DIVIDE_DATASET divide the dataset into an optimization and a validation
%dataset 
%   qt              ->  joint angle variables of the dataset
%   pt              ->  end effector position variables of the dataset
%   settings.ratio  ->  percentage of the data to use for optimization [0,1]
%   settings.random ->  true to employ a random seed to select the data from
%                       the original dataset; false to use a the seed 
%                       specified in settings.seed
%   settings.seed   ->  fixed seed
%   qo              ->  joint angle variables of the optimization dataset
%   po              ->  end-effector position variables of the optimization 
%                       dataset
%   qv              ->  joint angle variables of the validation dataset
%   pv              ->  end-effector position variables of the validation 
%                       dataset

ratio = settings.ratio;
random = settings.random;
seed = settings.seed;

if ~random
    rng(seed);
end

n_samples_tot = length(qt);
n_samples_opt = floor(ratio*n_samples_tot);

index = randperm(n_samples_tot,n_samples_opt);
qo = qt(index,:);
qt(index,:) = [];
qv = qt;
po = pt(:,index);
pt(:,index) = [];
pv = pt;
end

