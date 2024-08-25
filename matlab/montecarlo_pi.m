% Number of random points
N = 10000;

% Generate random points (x, y) within the unit square
x = rand(N, 1);
y = rand(N, 1);

% Calculate the distance of each point from the origin (0, 0)
distances = sqrt(x.^2 + y.^2);

% Count the number of points inside the quarter circle (distance <= 1)
inside_circle = sum(distances <= 1);

% Estimate pi using the ratio of points inside the quarter circle
pi_estimate = 4 * inside_circle / N;

% Display the estimated value of pi
disp(['Estimated value of Pi: ', num2str(pi_estimate)])

% Plot the points
figure;
hold on;
axis square;
% Points inside the circle
plot(x(distances <= 1), y(distances <= 1), 'b.');
% Points outside the circle
plot(x(distances > 1), y(distances > 1), 'r.');
% Plot the quarter circle
theta = linspace(0, pi/2, 100);
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);
title(['Monte Carlo Simulation for Pi, N = ', num2str(N)]);
xlabel('x');
ylabel('y');
legend('Inside Circle', 'Outside Circle', 'Quarter Circle');
hold off;
