function [DHP] = DH_par(version,q,parameters)
switch version
    case 'neck_4_joints'
        DHP = DH_par_neck_4_joints(q,parameters);
    otherwise
        DHP = [];
        disp('Error: mockup not recognised.')
        disp('Available mockup: "neck_4_joints"')
end
end

