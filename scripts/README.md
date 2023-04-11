# Main Scripts
## Scripts

### config.m
This script configures the parameters necessary for the design optimisation and analysis. 
It includes the libraries path, the mechanism description and the graphical configuration.
This script is automatically run by the optimisation and analysis scripts.
In this script it is possible to edit the variable "display_graph" to choose if display the plot in the optimisation scripts.
- display_graph = true -> plot enabled;
- display_graph = false -> plot disabled.

### main_data_preprocessing.m
This script generates the dataset by reading and preprocessing the raw data obtained using the Vicon MoCap system.
It creates a folder named "data_for_optimization" containing for each subject and for every trial the following variables:
- p_TCP.mat -> head position with respect to the thorax frame;
- q.mat -> joint angles;
- R_TCP.mat -> rotation matrix of the head frame with respect to the thorax frame.

### main_opt_all_sub.m
This script performs the optimisation procedure for all the subjects displaying all the performance indicators.

### main_opt_groups.m
This script performs the optimisation procedure for the three percentile groups displaying all the performance indicators.

### main_plot_experimental_trial.m
This script plots the markers position and the reconstructed torso and head frames for a specific subject and experimental trial.
Before running this script, select the subject and trials by editing the variables:
- subject_num
- trial_num
