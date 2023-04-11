function [z1,x2,y3] = find_angles_TB_ZXY(frames)
%FIND_ANGLES computes the Tait-Bryan ZXY angles from the thorax and head frames 
%   frames  ->  a cell containing the matrix representation of the head and 
%               thorax frames:  frame{1} = head frame 
%                               frame{2} = thorax frame 
%   z1      ->  angle around the z axis
%   x2      ->  angle around the x axis
%   y3      ->  angle around the y axis
rotm_head = frames{1};
rotm_thorax = frames{2};
rot_HT = rotm_thorax'*rotm_head;
z1 = atan2(-rot_HT(1,2),rot_HT(2,2));
x2 = atan2(rot_HT(3,2),sqrt(1-rot_HT(3,2)^2));
y3 = atan2(-rot_HT(3,1),rot_HT(3,3));
end

