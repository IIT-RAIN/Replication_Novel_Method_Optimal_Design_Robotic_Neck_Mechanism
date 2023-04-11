# Kinematic Library
## Functions

### [DHP] = DH_par(version,q,parameters)
Create a matrix with the Denavit Hartemberg Parameters of the robot given the joint angles
#### input
- version: string that identifies the robot version
- q: joint angles [rad]
- parameters: structure containing the geometrical parameters of the robotic neck
  - a1 
  - a3 		 
  - a4 		 
  - a_tcp 
  - d1 		 
  - d2 		 
  - d_tcp 
#### output
- DHP: matrix of the Denavit Hartemberg Parameters of the robot given the joint angles

### [dhp] = DH_par_neck_4_joints(q,parameters)
Create a matrix with the Denavit Hartemberg Parameters of the robot given the joint angles
#### input
- q: joint angles [rad]
- parameters: structure containing the geometrical parameters of the robotic neck
  - a1 
  - a3 		 
  - a4 		 
  - a_tcp 
  - d1 		 
  - d2 		 
  - d_tcp 
#### output
- dhp: matrix of the Denavit Hartemberg Parameters of the robot given the joint angles

### [ T ] = DH_trasformation_modified( dhp )
Create the homogeneouse transformation matrix starting from the Denavit Hartemberg Parameters
#### input
- dhp: matrix of the Denavit Hartemberg Parameters
#### output
- T: homogeneouse transformation

### [ p, T ] = DirectKinematic( dhp, Tw )
Compute the direct kinematic of a robot given its Denavit Hartemberg Parameters and the world frame
#### input
- dhp: matrix of the Denavit Hartemberg Parameters
- Tw: world frame
#### output
- p: pose of each line of the DHP matrix of the robot
  - x position
  - y position
  - z position
  - w quaternion element 
  - x quaternion element 
  - y quaternion element 
  - z quaternion element 
- T: cell array containing homogeneouse transformations of each line of the DHP matrix
  
### plotFrame(T,length,lineWidth)
Plot frames associated to each line of the DHP
#### input
- T: homogeneouse transformation
- length: length of the axes of the frame
- lineWidth: width of the axes of the frame

### plotRobot(pose,c)
Plot the head and thorax markers and frames
#### input
- pose: pose of each line of the DHP matrix of the robot
- c: color of the markers (default = 'k')
