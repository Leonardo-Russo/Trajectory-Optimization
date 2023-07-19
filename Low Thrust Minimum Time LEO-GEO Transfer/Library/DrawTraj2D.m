function DrawTraj2D(x, tspan, Q)
% Description: this function plots the 2D orbit of the S/C during the
% manoeuvre.

global savechoice

M = length(x);
tspan_step = 1.01;

DU = Q(1);
TU = Q(2);
r = DU * x(:, 1);
xi = x(:, 2);
Rleo = DU * Q(3);
Rgeo = DU * Q(4);


figure('Name', 'Plot of the 2D Orbit')
hold on

axis equal

xi_span = linspace(0, 2*pi, 5000);
plot(Rgeo*cos(xi_span), Rgeo*sin(xi_span), 'Color','#3061ff')
plot(Rleo*cos(xi_span), Rleo*sin(xi_span), 'Color','#3cc0e8')
xlabel('$x \ [km]$', 'Interpreter','latex')
ylabel('$y \ [km]$', 'Interpreter','latex')

plot_anyways = 1;

for i = 1 : M

    if i > 2

        if tspan(i) > tspan(i-1)*tspan_step || plot_anyways

            plot(r(i)*cos(xi(i)), r(i)*sin(xi(i)), 'Marker','.', 'MarkerSize',5, 'Color', '#ff9421')
            xlabel('$x \ [km]$', 'Interpreter','latex')
            ylabel('$y \ [km]$', 'Interpreter','latex')
            if savechoice == '1'
                exportgraphics(gcf, 'Output/manoeuvre.gif', 'Append', true)
            else
                pause(0.01)
            end
            plot_anyways = 0;

        else

            plot_anyways = 1;

        end

    end

    
end

plot(r.*cos(xi), r.*sin(xi), 'Color', '#ff9421', 'LineStyle','-', 'LineWidth', 2)
legend('GEO', 'LEO')

if savechoice == '1'
    exportgraphics(gcf, 'Output/manoeuvre.gif', 'Append', true)
end


end