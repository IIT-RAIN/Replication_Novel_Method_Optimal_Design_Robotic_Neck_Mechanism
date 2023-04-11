%compute the homogeneouse transformation starting from the dh_parameters
function [ T ] = DH_trasformation_modified( dhp )

T = [            cos(dhp(2)),                -sin(dhp(2)),             0,              dhp(3);
     sin(dhp(2))*cos(dhp(4)),     cos(dhp(2))*cos(dhp(4)),  -sin(dhp(4)),  -dhp(1)*sin(dhp(4));
     sin(dhp(2))*sin(dhp(4)),     cos(dhp(2))*sin(dhp(4)),   cos(dhp(4)),   dhp(1)*cos(dhp(4));
                           0,                           0,             0,                   1];
  
end

