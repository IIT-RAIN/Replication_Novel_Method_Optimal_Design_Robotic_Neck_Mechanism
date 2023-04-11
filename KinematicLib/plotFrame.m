function [] = plotFrame(T,length,lineWidth)

x = [length,0,0]';
y = [0,length,0]';
z = [0,0,length]';

Originf = T(1:3,4);
xf = Originf + T(1:3,1:3)*x;
yf = Originf + T(1:3,1:3)*y;
zf = Originf + T(1:3,1:3)*z;

plot3([Originf(1),xf(1)],[Originf(2),xf(2)],[Originf(3),xf(3)],'r','linewidth',lineWidth);
plot3([Originf(1),yf(1)],[Originf(2),yf(2)],[Originf(3),yf(3)],'g','linewidth',lineWidth);
plot3([Originf(1),zf(1)],[Originf(2),zf(2)],[Originf(3),zf(3)],'b','linewidth',lineWidth);
end

