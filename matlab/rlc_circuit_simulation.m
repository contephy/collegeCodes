function RLCcircuitSimulation
    R = 1000;   % resistance (ohms)
    L = 0.1;    % inductance (H)
    C = 1e-4;   % capacitance (F)
    V0 = 1;     % input voltage (V)
    
    % Differential equation
    odefun = @(t, y) [y(2); (V0 - y(2)*R - y(1)/C) / L];
    
    y0 = [0; 0]; % initial capacitor voltage and inductor current
    
    tspan = [0, 0.01];
    
    [t, y] = ode45(odefun, tspan, y0);
    
    % Plot results
    figure;
    plot(t, y(:, 1));
    title('Capacitor Voltage in RLC Circuit');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
end
