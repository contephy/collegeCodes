N = 10000;

x = rand(N, 1);
y = rand(N, 1);

distances = sqrt(x.^2 + y.^2);

inside_circle = sum(distances <= 1);

pi_estimate = 4 * inside_circle / N;

disp(['Estimated value of Pi: ', num2str(pi_estimate)])

% Plot
figure;
hold on;
axis square;
% Points inside the circle
plot(x(distances <= 1), y(distances <= 1), 'b.');
% Points outside the circle
plot(x(distances > 1), y(distances > 1), 'r.');

theta = linspace(0, pi/2, 100);
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);
title(['Monte Carlo Simulation for Pi, N = ', num2str(N)]);
xlabel('x');
ylabel('y');
legend('Inside Circle', 'Outside Circle', 'Quarter Circle');
hold off;
