import numpy as np
import matplotlib.pyplot as plt

# Parameters
L = 10.0  # length of the rod
Nx = 10  # number of spatial points
Nt = 100  # number of time steps
alpha = 0.01  # thermal diffusivity
dx = L / (Nx - 1)
dt = 0.01

# Initialize
u = np.zeros((Nx, Nt))
x = np.linspace(0, L, Nx)

# Initial condition
u[:, 0] = np.sin(np.pi * x / L)

# Time-stepping loop
for n in range(0, Nt-1):
    for i in range(1, Nx-1):
        u[i, n+1] = u[i, n] + alpha * dt / dx**2 * (u[i+1, n] - 2*u[i, n] + u[i-1, n])

# Plot results
plt.imshow(u, extent=[0, L, 0, Nt*dt], origin='lower', aspect='auto')
plt.colorbar(label='Temperature')
plt.xlabel('Position')
plt.ylabel('Time')
plt.title('Heat Equation Simulation')
plt.show()
