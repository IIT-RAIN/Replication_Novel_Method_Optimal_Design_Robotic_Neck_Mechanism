function [frame,origin] = find_frames(data,T0)
%FIND_FRAMES find the origin and the axis of the head and thorax frames
%   data    ->  a single row of the data_marker table of the dataset 
%               imported using import data_marker function
%   T0      ->  initial homogeneous transformation to remove the 
%               orientation and position offset offset of the head due to 
%               the markers placement error
%   frame   ->  a cell containing the matrix representation of the head and 
%               thorax frames:  frame{1} = head frame 
%                               frame{2} = thorax frame 
%   origin  ->  a mmatrix containing the origin of the head and thorax 
%               origins:    origin(:,1) = head origin 
%                           origin(:,2) = thorax origin 
%% Define thorax frame
frame_thorax_offset = 5;                                                   % define the offset along the x-axis from CLAV to define the frame origin -> offset = marker_diameter / 2

% midpoint definition
MST = ([data.STRN_X,data.STRN_Y,data.STRN_Z]+...                           % compute the midpoint between the STRN and T10 markers 
    [data.T10_X,data.T10_Y,data.T10_Z])/2;
MCLC = ([data.CLAV_X,data.CLAV_Y,data.CLAV_Z]+...                          % compute the midpoint between the CLAV and C7 markers 
    [data.C7_X,data.C7_Y,data.C7_Z])/2;
MTC = ([data.C7_X,data.C7_Y,data.C7_Z]+...                                 % compute the midpoint between the C7 and T10 markers 
    [data.T10_X,data.T10_Y,data.T10_Z])/2;
MCLS = ([data.CLAV_X,data.CLAV_Y,data.CLAV_Z]+...                          % compute the midpoint between the CLAV and STRN markers 
    [data.STRN_X,data.STRN_Y,data.STRN_Z])/2;

% axis and origin definition
z_axis_thorax = (MCLC-MST)/norm(MCLC-MST);                                 % define the z-axis as the unit vector with direction MCLC-MST
x_axis_thorax_temp = (MCLS-MTC)/norm(MCLS-MTC);                            % define temp x-axis as the unit vector with direction MCLS-MTC
y_axis_thorax = cross(z_axis_thorax,x_axis_thorax_temp);                   % define the y-axis as the unit vector orthogonal to x-axis and z-axis
y_axis_thorax = y_axis_thorax/norm(y_axis_thorax);
x_axis_thorax = cross(y_axis_thorax,z_axis_thorax);                        % define the x-axis as the unit vector orthogonal to y-axis and z-axis
origin_thorax = [data.CLAV_X,data.CLAV_Y,data.CLAV_Z]-...                  % define the origin of the thorax frame as the point at a distance frame_thorax_offset along the thorax x-axis from CLAV
    x_axis_thorax*frame_thorax_offset;

%% Define head frame
% midpoint definition
MFHD = ([data.LFHD_X,data.LFHD_Y,data.LFHD_Z]+...                          % compute the midpoint between the LFHD and RFHD markers 
    [data.RFHD_X,data.RFHD_Y,data.RFHD_Z])/2;
MBHD = ([data.LBHD_X,data.LBHD_Y,data.LBHD_Z]+...                          % compute the midpoint between the LBHD and RBHD markers 
    [data.RBHD_X,data.RBHD_Y,data.RBHD_Z])/2;
MLHD = ([data.LFHD_X,data.LFHD_Y,data.LFHD_Z]+...                          % compute the midpoint between the LFHD and LBHD markers 
    [data.LBHD_X,data.LBHD_Y,data.LBHD_Z])/2;
MRHD = ([data.RFHD_X,data.RFHD_Y,data.RFHD_Z]+...                          % compute the midpoint between the RFHD and RBHD markers 
    [data.RBHD_X,data.RBHD_Y,data.RBHD_Z])/2;

CPHD = (MFHD+MBHD)/2;                                                      % head origin as midpoint between MFHD and MBHD

% axis definition
x_axis_head = (MFHD-MBHD)/norm(MFHD-MBHD);                                 % define the x-axis as the unit vector with direction MFHD-MBHD
y_axis_head_temp = (MRHD-MLHD)/norm(MRHD-MLHD);                            % define temp y-axis as the unit vector with direction MRHD-MLHD
z_axis_head = cross(y_axis_head_temp,x_axis_head);                         % define the z-axis as the unit vector orthogonal to x-axis and y-axis
z_axis_head = z_axis_head/norm(z_axis_head);
y_axis_head = cross(z_axis_head,x_axis_head);                              % define the y-axis as the unit vector orthogonal to x-axis and z-axis

%% output
p0 = T0(1:3,4);
R0 = T0(1:3,1:3);
frame{1}= R0*[x_axis_head',y_axis_head',z_axis_head'];
frame{2}= [x_axis_thorax',y_axis_thorax',z_axis_thorax'];
origin = [CPHD'-p0,origin_thorax'];
end

