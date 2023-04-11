function [] = plot_markers(data,T0,view_ori,c)
%plot_markers Plot the head and thorax amrkers and frames
%   data    ->  a single row of the data_marker table of the dataset 
%               imported using import data_marker function
%   T0      ->  initial homogeneous transformation to remove the 
%               orientation and position offset offset of the head due to 
%               the markers placement error
%   view    ->  vector containing the view option of the figure
%   c       ->  color of the markers
if nargin < 4
    c = 'k';
end
if nargin < 3
    view(60,30);
end

%% create label for the markers
% label offset with respect to the marker
off_x = 0;
off_y = 0;
off_z = 25;

marker_name = ["LFHD","RFHD","LBHD","RBHD","C7","T10","CLAV","STRN", "LSHO", "RSHO"];      % define the markers name
marker_name_cell = cellstr(marker_name);
frame_str = strcat("Frame: ",num2str(data.Frame));                         % declare the video frame number
head_frame_str = ("$O_h$");
thorax_frame_str = ("$O_t$");

%% create the head and torso markers matrix
data_vector = data.Variables;
data_vector(1) = [];                                                       % remove the frame column
data_matrix = reshape(data_vector,3,10);                                   % reshape the data in a matrix 3x10 (3 x-y-z components x 8 markers)
head_markers = [data_matrix(:,1),data_matrix(:,2),data_matrix(:,4),...
    data_matrix(:,3),data_matrix(:,1)];                                    % select the head markers
thorax_markers = [data_matrix(:,5),data_matrix(:,6),data_matrix(:,8),...
    data_matrix(:,7),data_matrix(:,9),data_matrix(:,5),data_matrix(:,10),...
    data_matrix(:,7)];                                                     % select the thorax markers

%% Create head and thorax frame
frame_axis_length = 50;                                                    % define the frame axis lenght
frame_axis_lineWidth = 1.5;                                                % define the frame axis width

[frames,origins] = find_frames(data,T0);

frame_head_x = origins(:,1) + frames{1}(:,1)*frame_axis_length;
frame_head_y = origins(:,1) + frames{1}(:,2)*frame_axis_length;
frame_head_z = origins(:,1) + frames{1}(:,3)*frame_axis_length;

frame_thorax_x = origins(:,2) + frames{2}(:,1)*frame_axis_length;
frame_thorax_y = origins(:,2) + frames{2}(:,2)*frame_axis_length;
frame_thorax_z = origins(:,2) + frames{2}(:,3)*frame_axis_length;
%% plot markers and frame
hold on;
% plot markers name
text(data_matrix(1,:)+off_x,data_matrix(2,:)+off_y,data_matrix(3,:)+off_z,...
    marker_name_cell,'Fontsize', 9,'Interpreter','latex',...
    'Color',[0.5,0.5,0.5],'HorizontalAlignment','center');%  'Color',[0.75,0.75,0.75],'HorizontalAlignment','center');
% plot head markers
plot3(head_markers(1,:),head_markers(2,:),head_markers(3,:),...
    '*-','MarkerSize',8,'Color',c);
% plot thorax markers
plot3(thorax_markers(1,:),thorax_markers(2,:),thorax_markers(3,:),...
    '*-','MarkerSize',8,'Color',c);
text(thorax_markers(1,4),thorax_markers(2,4),thorax_markers(3,4)-75,frame_str,...
    'Units','data','Fontsize', 9,'Interpreter','latex',...
    'Color',[0.25,0.25,0.25],'HorizontalAlignment','center');%     'Color',[0.5,0.5,0.5],'HorizontalAlignment','center');
% plot head frame
plot3([origins(1,1),frame_head_x(1)],[origins(2,1),frame_head_x(2)],[origins(3,1),frame_head_x(3)],...
    'r','linewidth',frame_axis_lineWidth);
plot3([origins(1,1),frame_head_y(1)],[origins(2,1),frame_head_y(2)],[origins(3,1),frame_head_y(3)],...
    'g','linewidth',frame_axis_lineWidth);
plot3([origins(1,1),frame_head_z(1)],[origins(2,1),frame_head_z(2)],[origins(3,1),frame_head_z(3)],...
    'b','linewidth',frame_axis_lineWidth);
text(frame_head_z(1),frame_head_z(2),frame_head_z(3)+25,head_frame_str,...
    'Units','data','Fontsize', 9,'Interpreter','latex',...
    'Color',[0.25,0.25,0.25],'HorizontalAlignment','center');%     'Color',[0.5,0.5,0.5],'HorizontalAlignment','center');
% plot thorax frame
plot3([origins(1,2),frame_thorax_x(1)],[origins(2,2),frame_thorax_x(2)],[origins(3,2),frame_thorax_x(3)],...
    'r','linewidth',frame_axis_lineWidth);
plot3([origins(1,2),frame_thorax_y(1)],[origins(2,2),frame_thorax_y(2)],[origins(3,2),frame_thorax_y(3)],...
    'g','linewidth',frame_axis_lineWidth);
plot3([origins(1,2),frame_thorax_z(1)],[origins(2,2),frame_thorax_z(2)],[origins(3,2),frame_thorax_z(3)],...
    'b','linewidth',frame_axis_lineWidth);
text(frame_thorax_z(1),frame_thorax_z(2),frame_thorax_z(3)+25,thorax_frame_str,...
    'Units','data','Fontsize', 9,'Interpreter','latex',...
    'Color',[0.25,0.25,0.25],'HorizontalAlignment','center');%     'Color',[0.5,0.5,0.5],'HorizontalAlignment','center');


xlabel('x [mm]');
ylabel('y [mm]');
zlabel('z [mm]');
axis equal;
view(view_ori);
hold off   
end

