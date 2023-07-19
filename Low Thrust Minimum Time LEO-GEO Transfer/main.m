%% Homework 5 - Leonardo Russo 2015563

close all
clear all
clc

addpath("Library\")

%% Options

global savechoice
savechoice = '0';

% Define Options for fmincon()
optionsFMIN = optimoptions('fmincon');
optionsFMIN.StepTolerance = 1e-13;
optionsFMIN.Display = 'iter';
optionsFMIN.ConstraintTolerance = 1e-9;
optionsFMIN.Algorithm = 'interior-point';

% Define the Options for ode113()
Tol0 = 1e-9;
Tol1 = 1e-11;
optionsODE = odeset('RelTol', Tol0, 'AbsTol',Tol1);

%% Define Known Quantities

rE = 6371;      % km
Rleo = 7000;    % km
Rgeo = 42164;   % km
mu = 398600.4415;   % km^3/s^2

DU = rE;
TU = sqrt(DU^3 / mu);

g0 = 9.81;  % m/s^2
c = 20;     % km/s
uT_max = 0.05*g0;   % m/s^2

% Rewrite the Quantities in DU and TU
Rleo = Rleo / DU;   % DU
Rgeo = Rgeo / DU;   % DU
mu = 1;             % DU^3/TU^2

g0 = g0*1e-3 / DU * TU^2;   % DU/TU^2
c = c / DU * TU;            % DU/TU
uT_max = uT_max*1e-3 / DU * TU^2;   % DU/TU^2


%% Minimization of tf

xini = [Rleo, 0, 0, sqrt(mu/Rleo)]';
xfin = [Rgeo, 0, sqrt(mu/Rgeo)]';
p = [c, uT_max, mu]';
t0 = 0;

C0 = [xini; xfin; p; t0];

lambda0_guess = [-1 0.2 -1]';
tf_guess = 10;

X0 = [lambda0_guess; tf_guess];

A = [];
B = [];
Aeq = [];
Beq = [];
LB = [-1, -1, -1, 0];
UB = [1, 1, 1, +Inf];


[Xf, optval, outc] = fmincon(@(X0) minTimeTransf(X0), X0, A, B, Aeq, Beq, LB, UB, @(X0) nonlinconstr(X0, C0), optionsFMIN);

lambdaf = Xf(1:3);
tf = Xf(4);


%% Evaluate the Optimal Trajectory

% Define Initial State for the Integration
S0 = [xini; lambdaf; p];

[tspan, S] = ode113('DynamicalModel', [t0, tf], S0, optionsODE);

x = S(:, 1:4);
lambda = S(:, 5:7);

r = x(:, 1);
vr = x(:, 3);
vt = x(:, 4);

M = length(x);
u = zeros(M, 1);

for i = 1 : M
    
    lambda3 = lambda(i, 2);
    lambda4 = lambda(i, 3);

    sinu = -lambda3/sqrt(lambda3^2+lambda4^2);
    cosu = -lambda4/sqrt(lambda3^2+lambda4^2);

    u(i) = atan2(sinu, cosu);

end


%% Plot of the Results

Q = [DU, TU, Rleo, Rgeo];
DrawTraj2D(x, tspan, Q)


figure('Name', 'Plot of the Radial Distance')

plot(tspan*TU, r*DU, 'LineWidth', 1.4)
xlabel('$t \ [s]$', 'Interpreter','latex', 'FontSize', 12)
ylabel('$r \ [km]$', 'Interpreter','latex', 'FontSize', 12)
if savechoice == '1'
    saveas(gcf, strcat('Output\r.jpg'))
end


figure('Name', 'Plot of the Velocity Components')

hold on
plot(tspan*TU, vr*DU/TU, 'Color', '#3cc0e8', 'LineWidth', 1.4)
plot(tspan*TU, vt*DU/TU, 'Color', '#eb2880', 'LineWidth', 1.5)
xlabel('$t \ [s]$', 'Interpreter','latex', 'FontSize', 12)
ylabel('$v_{i} \ [km/s]$', 'Interpreter','latex', 'FontSize', 12)
legend('$v_{r}$', '$v_{t}$', 'Interpreter', 'latex')
if savechoice == '1'
    saveas(gcf, strcat('Output\velocities.jpg'))
end


figure('Name', 'Plot of the Control Angle Alpha')

plot(tspan*TU, rad2deg(u), 'LineStyle','-', 'LineWidth', 1.4)
xlabel('$t \ [s]$', 'Interpreter','latex', 'FontSize', 12)
ylabel('$\alpha \ [deg]$', 'Interpreter','latex', 'FontSize', 12)
if savechoice == '1'
    saveas(gcf, strcat('Output\alpha.jpg'))
end









