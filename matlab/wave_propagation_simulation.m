function waveEquationSimulation
    % Parameters
    L = 10;     % length of the medium (m)
    T = 1;      % total time (s)
    Nx = 100;   % number of spatial points
    Nt = 500;   % number of time steps
    c = 1;      % wave speed (m/s)
    
    % Discretization
    dx = L / (Nx - 1);
    dt = T / Nt;
    x = linspace(0, L, Nx);
    t = linspace(0, T, Nt);
    
    % Initial conditions
    u = zeros(Nx, Nt);
    u(:, 1) = sin(pi * x / L); % initial displacement
    
    % Time-stepping loop
    for n = 1:Nt-1
        for i = 2:Nx-1
            u(i, n+1) = 2 * (1 - c^2 * dt^2 / dx^2) * u(i, n) - u(i, n-1) + c^2 * dt^2 / dx^2 * (u(i+1, n) + u(i-1, n));
        end
    end
    
    % Plot results
    figure;
    surf(t, x, u);
    title('Wave Propagation');
    xlabel('Time (s)');
    ylabel('Position (m)');
    zlabel('Displacement');
end
