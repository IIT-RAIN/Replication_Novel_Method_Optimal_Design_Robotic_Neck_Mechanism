# Data Analysis Library
## Functions

### [dataset] = create_dataset(subjects)
Create a dataset containing all the information about the experiments performed for the head motion measurements
#### input
- subjects: select the subjects to include in the dataset
#### output
- dataset: sturcture containing all the data required:
  - dataset.subject{i}.session{j}.trial{k}.data_frame = anatomic angles of the head, thorax and neck
  - dataset.subject{i}.session{j}.trial{k}.data_markers = position of all the markers located on the head and thorax
  
### [qo,qv,po,pv] = divide_dataset(qt,pt,settings)
Divide the dataset into an optimization and a validation dataset 
#### input
- qt: joint angle variables of the dataset
- pt: end effector position variables of the dataset
- settings.ratio: percentage of the data to use for optimization [0,1]
- settings.random: true to employ a random seed to select the data from the original dataset; false to use a the seed specified in settings.seed
- settings.seed: fixed seed
#### output
- qo: joint angle variables of the optimization dataset
- po: end-effector position variables of the optimization dataset
- qv: joint angle variables of the validation dataset
- pv: end-effector position variables of the validation dataset

### [z1,x2,y3] = find_angles_TB_ZXY(frames)
Computes the Tait-Bryan ZXY angles from the thorax and head frames
#### input
- frames: a cell containing the matrix representation of the head and thorax frames:
  - frame{1} = head frame 
  - frame{2} = thorax frame 
#### output
- z1: angle around the z axis
- x2: angle around the x axis
- y3: angle around the y axis

### [frame,origin] = find_frames(data, T0)
Find the origin and the axis of the head and thorax frames
#### input:
  - data:  a single row of the data_marker table of the dataset imported using import data_marker function 
  - T0: initial homogeneous transformation to remove the orientation and position offset offset of the head due to the markers placement error
#### output:
- frame:  a cell containing the matrix representation of the head and thorax frames
  - frame{1} = head frame 
  - frame{2} = thorax frame 
- origin: matrix containing the origin of the head and thorax origins    
  - origin(:,1) = head origin 
  - origin(:,2) = thorax origin 
  
### data_frame = import_data_frame(filename, dataLines)
Import the anatomic angles from a text file
#### input
- filename: name of the file to import
- dataLines: positive scalar integer or a N-by-2 array of positive scalar integers for dis-contiguous row intervals to select the row.
#### output
- data_frame: a table containing the anatomic angles

### data_markers = import_data_marker(file)
Import the markers position from a text file
#### input
- filename: name of the file to import
- dataLines: positive scalar integer or a N-by-2 array of positive scalar integers for dis-contiguous row intervals to select the row.
#### output
- data_marker: a table containing the markers position

###  variables_name = importVariablesName(filename)
Import the markers variables name from a text file
#### input
- filename: name of the file to import
#### output
- variables_name: a table containing the name of the markes

### plot_markers(data,view_ori,c)
Plot the head and thorax markers and frames
#### input
- data:  a single row of the data_marker table of the dataset imported using import data_marker function
- view_ori: vector containing the view option of the figure (default = [60 30])
- c: color of the markers (default = 'k')

## Data Folder Structure
```
experiments
│   README.md 
│
└───subject_01
│   └───session_01
│   |   └───trial_01
│   |   |   |data_frame.csv
│   |   |   |data_marker.csv
|   |   |
│   |   └───trial_02
│   |   |   |data_frame.csv
│   |   |   |data_marker.csv
|   |   |
│   |   └───trial_03
│   |   |   |data_frame.csv
│   |   |   |data_marker.csv
|   |   |
│   |   └───trial_04
│   |   |   |data_frame.csv
│   |   |   |data_marker.csv
|   |   |
│   |   └───trial_05
│   |       |data_frame.csv
│   |       |data_marker.csv
|   |
│   └───session_02
│   |   └───trial_01
|   |   └───trial_02
|   |   └───trial_03
|   |   └───trial_04
|   |   └───trial_05
|   .
|   .
|   .
└───subject_02
.   
.   
.   

```
