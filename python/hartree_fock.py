import numpy as np
from scipy.linalg import eigh

# Define the atomic number and basis set
Z = 2  
n_basis = 2 

# Define overlap matrix (S), kinetic energy matrix (T), and potential energy matrix (V)
S = np.array([[1.0, 0.1], [0.1, 1.0]])
T = np.array([[1.0, 0.1], [0.1, 1.0]])
V = np.array([[0.5, 0.1], [0.1, 0.5]])

F = np.zeros((n_basis, n_basis))

def compute_fock_matrix(P):
    # For simplicity, we are ignoring the electron-electron repulsion terms here.
    return T + V + np.dot(P, np.dot(S, P))

def compute_density_matrix(C, n_basis):
    P = np.zeros((n_basis, n_basis))
    for i in range(n_basis):
        for j in range(n_basis):
            P[i, j] = 2 * C[i, 0] * C[j, 0]  # Only one occupied orbital in this example
    return P


def hartree_fock(n_basis, tol=1e-8, max_iter=100):
    # Initialize the coefficient matrix and density matrix
    C = np.eye(n_basis)
    P = compute_density_matrix(C, n_basis)
    
    for iteration in range(max_iter):
        F = compute_fock_matrix(P)
        
        # Diagonalize the Fock matrix
        eps, C_new = eigh(F, S)
        
        P_new = compute_density_matrix(C_new, n_basis)
        
        # Check for convergence
        if np.max(np.abs(P_new - P)) < tol:
            print(f'Converged after {iteration + 1} iterations.')
            break
        
        P = P_new
        C = C_new
    
    return C, eps

C, eps = hartree_fock(n_basis)
print("Molecular Orbital Coefficients:\n", C)
print("Orbital Energies:\n", eps)
