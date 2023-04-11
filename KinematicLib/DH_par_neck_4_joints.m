function [dhp] = DH_par_neck_4_joints(q,parameters)

%Geometric parameters to optimise
a1 		= parameters.a1;
a3 		= parameters.a3;
a4 		= parameters.a4;
a_tcp 	= parameters.a_tcp;
d1 		= parameters.d1;
d2 		= parameters.d2;
d_tcp 	= parameters.d_tcp;

%DH parameters
d = [d1;d2;0;0;d_tcp];
a = [a1;0;a3;a4;a_tcp];
q_off = [pi/2;pi/2;0;pi/2;0];
alpha = [0;pi/2;pi/2;0;pi/2];
q = [q;0]+q_off;

dhp = [d,q,a,alpha];