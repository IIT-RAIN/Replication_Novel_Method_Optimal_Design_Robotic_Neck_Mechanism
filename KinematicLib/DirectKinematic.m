%compute the direct kinematic of an object
function [ p, T ] = DirectKinematic( dhp, Tw )

    [n,~] = size(dhp);
    T_TCP = Tw;
    p = zeros(7,n);
    T = cell(n,1);

    for i = 1 : n
        T_TCP = T_TCP*DH_trasformation_modified(dhp(i,:));
        T{i} = T_TCP;
        p(1:3,i) = T_TCP(1:3,4);
        p(4:end,i) = (rotm2quat(T_TCP(1:3,1:3)))';

    end
end

