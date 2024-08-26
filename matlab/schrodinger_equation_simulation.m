function schrodingerEquation
    % Parameters
    L = 10;     % domain length
    Nx = 100;   % number of spatial points
    Nt = 500;   % number of time steps
    dx = L / (Nx - 1);
    dt = 0.01;  % time step size
    x = linspace(0, L, Nx);
    
    % Potential well (infinite square well)
    V = zeros(1, Nx);
    
    % Initial wave packet
    psi = exp(-((x - L/2).^2) / 0.1) .* exp(1i * 2 * pi * 5 * x / L);
    psi = psi / norm(psi);
    
    % Time evolution using Crank-Nicolson method
    A = diag(2 * ones(1, Nx)) - diag(ones(1, Nx-1), 1) - diag(ones(1, Nx-1), -1);
    A = A / dx^2;
    B = eye(Nx) - 1i * dt / 2 * (A + diag(V));
    C = eye(Nx) + 1i * dt / 2 * (A + diag(V));
    
    % Time-stepping loop
    for n = 1:Nt
        psi = B \ (C * psi.');
        psi = psi.';
        
        % Plot results
        if mod(n, 50) == 0
            figure;
            plot(x, abs(psi).^2);
            title(['Wave Packet at t = ', num2str(n * dt)]);
            xlabel('Position');
            ylabel('Probability Density');
        end
    end
end
