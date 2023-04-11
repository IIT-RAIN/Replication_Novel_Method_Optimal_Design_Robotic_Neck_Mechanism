function [] = plotRobot(pose,c)
    if nargin == 1
        c = 'k';
    end

   plot3(pose(1,:),pose(2,:),pose(3,:),'color',c,'linewidth',3)
   
end

