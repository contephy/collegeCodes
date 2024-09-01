import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d
import numpy as np

# User inputs
a = float(input("Enter the value of lattice constant (e.g., 2.46 for Graphene): ")) 
t = float(input("What is the nearest neighbour hopping energy (e.g., 2.8 eV for Graphene): "))

# Generate kx, ky meshgrid
kx = np.arange(-1, 1, 0.025)
ky = np.arange(-1, 1, 0.025)
kx, ky = np.meshgrid(kx, ky)

cos_kx = np.cos((3/2) * kx * a)
cos_ky = np.cos((np.sqrt(3)/2) * ky * a)
z = t * np.sqrt(1 + 4 * cos_kx * cos_ky + 4 * cos_ky**2)

# Plotting
fig = plt.figure()
ax = plt.axes(projection="3d")

ax.plot_surface(kx, ky, z, cmap='autumn')
ax.plot_surface(kx, ky, -z, cmap='winter')

# Set labels
ax.set_xlabel('kx')
ax.set_ylabel('ky')
ax.set_zlabel('E(k)')

plt.show()
