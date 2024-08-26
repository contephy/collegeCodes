function RLCcircuitSimulation
    % Parameters
    R = 1000;   % resistance (ohms)
    L = 0.1;    % inductance (H)
    C = 1e-4;   % capacitance (F)
    V0 = 1;     % input voltage (V)
    
    % Differential equation
    odefun = @(t, y) [y(2); (V0 - y(2)*R - y(1)/C) / L];
    
    % Initial conditions
    y0 = [0; 0]; % initial capacitor voltage and inductor current
    
    % Time span
    tspan = [0, 0.01];
    
    % Solve ODE
    [t, y] = ode45(odefun, tspan, y0);
    
    % Plot results
    figure;
    plot(t, y(:, 1));
    title('Capacitor Voltage in RLC Circuit');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
end
