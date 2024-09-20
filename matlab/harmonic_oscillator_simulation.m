function harmonicOscillator
    m = 1;      % mass (kg)
    k = 10;     % spring constant (N/m)
    b = 0.5;    % damping coefficient (Ns/m)
    F = @(t) 0; % external force (N)
    
    odefun = @(t, y) [y(2); (F(t) - b * y(2) - k * y(1)) / m];

    y0 = [1; 0]; % initial displacement and velocity
    
    tspan = [0, 10];
    
    [t, y] = ode45(odefun, tspan, y0);
    
    % Plot results
    figure;
    plot(t, y(:, 1));
    title('Harmonic Oscillator');
    xlabel('Time (s)');
    ylabel('Displacement (m)');
end
