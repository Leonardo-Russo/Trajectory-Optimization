function [ineq, equal] = nonlinconstr(X0, C0)
% Description: this function takes as input the unknown quantities inside X
% and returns the vector of the NON-LINEAR inequality and equality
% constraints.

% Matlab Help: accepts X and returns the vectors C and Ceq, representing the nonlinear 
% inequalities and equalities respectively. fmincon minimizes FUN such 
% that C(X) <= 0 and Ceq(X) = 0.

ineq_tol = 1e-3;

% Import Data from Input
lambda0 = X0(1:3);
tf = X0(4);

xini = C0(1:4);
xfin = C0(5:7);
p = C0(8:10);
t0 = C0(11);


x0 = xini;

Y0 = [x0; lambda0; p];

% Perform the Integration to Obtain Final Values
Tol0 = 1e-9;
Tol1 = 1e-11;
options = odeset('RelTol', Tol0, 'AbsTol',Tol1);

[~, Y] = ode113('DynamicalModel', [t0, tf], Y0, options);


% Store Final Results
Yf = Y(end, :);
xf = Yf(1:4)';
lambdaf = Yf(5:7)';

Xf = [lambdaf; tf];
Cf = [C0(1:4); xf; C0(8:end)];


% Compute Hf
Hf = get_Hf(Xf, Cf);


% Assign Output Values
ineq = Hf + ineq_tol;

Psif = [xf(1); xf(3:4)] - xfin;
equal = Psif;


end