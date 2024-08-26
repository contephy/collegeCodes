function pendulumSimulation
    % Parameters
    g = 9.81; % acceleration due to gravity (m/s^2)
    L = 1;    % length of the pendulum (m)
    theta0 = 0.1; % initial angle (rad)
    omega0 = 0; % initial angular velocity (rad/s)
    tspan = [0, 10]; % time span (s)
    
    % Differential equation
    odefun = @(t, y) [y(2); - (g / L) * sin(y(1))];
    
    % Initial conditions
    y0 = [theta0; omega0];
    
    % Solve ODE
    [t, y] = ode45(odefun, tspan, y0);
    
    % Plot results
    figure;
    plot(t, y(:, 1));
    title('Pendulum Motion');
    xlabel('Time (s)');
    ylabel('Angle (rad)');
end
