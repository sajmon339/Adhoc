//
clc
clf
//a1=newaxes()
//a1.axes_bounds=[0,0,1.0,0.5];
//a2=newaxes()
//a2.axes_bounds=[0,0.5,1.0,0.5];
//
//sca=(a1)
//t=0:0.1:20
//plot(t,cos(t))
//title('wykres 2')
//
//sca=(a2)
//t=0:0.1:4
//plot(t,sin(t))
//title('wykres 2')


clc
clf

figure(0)
W=[0.69 1.24 0.32 -2.8 -5.84 -2.81 10.88 27 18.55]
S=[0.4 0.8 1.6 2.1 2.8 3.3 3.5 3.8 4.5]

plot (W)
plot(S,W, 'ro-')

// zadanie 3
clc
clf

t = 0:0.1:10;
y = cos(t) .* exp(sin(t));
plot(t, y);
xlabel('t');
ylabel('y');
title('Wykres funkcji y = cos(t) * e^(sin(t))');

//zadanie 4
clc
clf

x = linspace(0, 2*%pi, 1000);
sin_x = sin(x);
sin2_x = sin(x).^2;
sin3_x = sin(x).^3;

plot(x, sin_x, 'r-');
plot(x, sin2_x, 'b--');
plot(x, sin3_x, 'k:');

xlabel('x');
ylabel('y');
title('Wykresy funkcji sin(x), sin^2(x) i sin^3(x)');
legend('sin(x)', 'sin^2(x)', 'sin^3(x)');

// 5 

clc
clf

A=2
B=3
t=0:0.1:20
y1=A*exp(B*sin(t))

plot(t,y1, 'k-')

A=1
B=-3
y2=A*exp(B*sin(t))

plot(t,y2, 'b:')
set(gca(),"grid",[1 1])

title("Wykres funkcji y=A*exp(B*sin(t))")
xlabel("oś x")
ylabel("oś y")
legend(["A=1, B=3","A=-1, B=-3"])

//zadanie 6
clc
clf


x = linspace(0, 4*%pi, 1000);
w = cos(x) - 1;
z = sin(1 ./ (x.^2 + 1));

scf(0);
plot(x, w);
xlabel('x');
ylabel('w');
title('w = cos(x) - 1');

scf(1);
plot(x, z);
xlabel('x');
ylabel('z');
title('z = sin(1 / (x^2 + 1))');

scf(2);
plot(x, w, 'r-');
plot(x, z, 'b--');
xlabel('x');
ylabel('Wartości funkcji');
title('Wykresy funkcji w i z');
legend(['w = cos(x) - 1'], ['z = sin(1 / (x^2 + 1))']);

// zadanie 7

clc
clf


x = linspace(-10, 10, 1000);
y = sin(x);
z = cos(x) .* sin(y);
plot(x, z);
xlabel('x');
ylabel('z');
title('z = cos(x) * sin(y) gdzie y = sin(x)');

//zadanie 8

x = linspace(-5, 5, 100);
y = linspace(-5, 5, 100);
[X, Y] = meshgrid(x, y);
Z = (X - Y).*(X + Y) + exp(sqrt(X.^2 + Y.^2));

surf(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('f(x, y)');
title('f(x, y) = (x - y)(x + y) + e^(sqrt(x^2 + y^2))');


//9

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




