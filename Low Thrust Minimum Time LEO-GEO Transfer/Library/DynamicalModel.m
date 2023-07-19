function dX = DynamicalModel(t, X)
% this function is used for the integration in time of the unknown
% quantities in X.

% Initialize Derivatives
N = length(X);
dX = zeros(N, 1);

% Import Data from Input
x = X(1:4);
lambda = X(5:7);
p = X(8:10);

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

c = p(1);
uT_max = p(2);
mu = p(3);

lambda1 = lambda(1);
lambda2 = 0;
lambda3 = lambda(2);
lambda4 = lambda(3);


% Compute Local Variables
sinu = -lambda3/sqrt(lambda3^2+lambda4^2);
cosu = -lambda4/sqrt(lambda3^2+lambda4^2);

aTr = uT_max*c / (c - uT_max*t) * sinu;
aTt = uT_max*c / (c - uT_max*t) * cosu;


% Assign Derivative Values
dX(1) = x3;
dX(2) = x4/x1;
dX(3) = -mu/x1^2 + x4^2/x1 + aTr;
dX(4) = -x4*x3/x1 + aTt;

dX(5) = lambda2*x4/x1^2 - lambda3*(2*mu/x1^3 - x4^2/x1^2) - lambda4*(x4*x3/x1^2);
dX(6) = -lambda1 + lambda4*x4/x1;
dX(7) = -lambda2/x1 - lambda3*2*x4/x1 + lambda4*x3/x1;


end
