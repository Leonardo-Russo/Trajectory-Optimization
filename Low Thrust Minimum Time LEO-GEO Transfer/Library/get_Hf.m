function Hf = get_Hf(Xf, C0)
% Description: this functions takes as input the raw output of the
% integration and evaluates Hf.

% Import Data from Input
lambdaf = Xf(1:3);
tf = Xf(4);

x0 = C0(1:4);
xf = C0(5:7);
p = C0(8:10);
t0 = C0(11);

x1f = xf(1);
x3f = xf(2);
x4f = xf(3);

c = p(1);
uT_max = p(2);
mu = p(3);

lambda1f = lambdaf(1);
lambda2f = 0;
lambda3f = lambdaf(2);
lambda4f = lambdaf(3);


% Compute Local Variables
sinuf = -lambda3f/sqrt(lambda3f^2+lambda4f^2);
cosuf = -lambda4f/sqrt(lambda3f^2+lambda4f^2);


% Evaluate Hf
Hf = lambda1f*x3f + lambda2f*x4f/x1f + lambda3f*(-mu/x1f^2 + x4f^2/x1f + (uT_max*c*sinuf)/(c-uT_max*tf) + lambda4f*(x4f*x3f/x1f + (uT_max*c*cosuf)/(c-uT_max*tf)));


end