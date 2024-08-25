import math
import numpy as np
import matplotlib.pyplot as plt

# Taking R2/y constant.
y = float(input("What is the value of R2? "))
r1 = float(input("What is the start value of R1? "))
r2 = float(input("What is the end value of R1? "))
c = float(input("What is the step value of R1? "))

# Range for R1/x values.
X = np.arange(r1, r2, c)
n = len(X)

# Precompute constant values for efficiency
const_factor = (8 / 3.14) * (1 / 3.14)

# Pre-allocate arrays for psi values
A = np.zeros(n)
B = np.zeros(n)

# Calculate psi(1,2) and psi(2,1) values for R1 and R2
for ind, x in enumerate(X):
    exp_neg_4x = math.exp(-4 * x)
    exp_neg_2y = math.exp(-2 * y)
    exp_neg_4y = math.exp(-4 * y)
    exp_neg_2x = math.exp(-2 * x)
    
    A[ind] = const_factor * exp_neg_4x * (1 - 2 * y + y**2) * exp_neg_2y
    B[ind] = const_factor * exp_neg_4y * (1 - 2 * x + x**2) * exp_neg_2x

# Calculate Symmetric and Anti-Symmetric solutions
S = ((A + B) ** 2) / 2
AS = ((A - B) ** 2) / 2

# Calculate J values (|R1 - R2|)
J = np.abs(X - y)

####################################.........Graph Plotting........#########################################
fig, ax1 = plt.subplots()
ax1.plot(J, S, 'b-')
ax1.set_xlabel('|R1 - R2|')
ax1.set_ylabel('Symmetric Probability Distribution', color='b')
ax1.tick_params('y', colors='b')

ax2 = ax1.twinx()
ax2.plot(J, AS, 'r-')
ax2.set_ylabel('Anti-Symmetric Probability Distribution', color='r')
ax2.tick_params('y', colors='r')

fig.tight_layout()
plt.show()
