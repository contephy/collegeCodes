import numpy as np
import matplotlib.pyplot as plt
from scipy.special import hermite
from scipy.constants import hbar, m, omega

# Parameters
x = np.linspace(-5, 5, 1000)
n = 0  # quantum number

# Harmonic oscillator wavefunction
def psi_n(x, n):
    coef = 1 / np.sqrt(2**n * np.math.factorial(n)) * (m * omega / (np.pi * hbar))**0.25
    return coef * np.exp(-0.5 * m * omega * x**2 / hbar) * hermite(n)(np.sqrt(m * omega / hbar) * x)

# Calculate wavefunction
wavefunction = psi_n(x, n)

# Plot results
plt.plot(x, wavefunction**2)
plt.xlabel('x')
plt.ylabel(r'$\psi^2(x)$')
plt.title('Quantum Harmonic Oscillator Wavefunction (n=0)')
plt.show()
