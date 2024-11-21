
x = linspace(-%pi, 2*%pi, 100);
y = linspace(-%pi, 2*%pi, 100);
[X, Y] = meshgrid(x, y);
Z = sin(X).*cos(Y);

scf(0);
mesh(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('mesh sin(x)cos(y)');

scf(1);
plot3d(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('plot3d sin(x)cos(y)');

scf(2);
contour(X, Y, Z);
xlabel('X');
ylabel('Y');
title('contour sin(x)cos(y)');
