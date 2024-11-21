x = linspace(-5, 5, 100);
y = linspace(-5, 5, 100);
[X, Y] = meshgrid(x, y);
Z = (X - Y).*(X + Y) + exp(sqrt(X.^2 + Y.^2));

clf();
surf(X, Y, Z);
xgrid();
