import math
import random

# Asking for Parameters
p = int(input("Enter the number of different species: "))
K = {}
n = 0
print("Input details for all the different species:")
for i in range(p):
    s = input(f"\tEnter the symbol of species {i+1}: ")
    m = int(input(f"\tEnter the number of atoms of species {i+1}: "))
    K[i] = {'symbol': s, 'count': m}
    n += m
print("\n")

g1 = int(input("Enter the number of One Dimensional Geometries: "))
g2 = int(input("Enter the number of Two Dimensional Geometries: "))
g3 = int(input("Enter the number of Three Dimensional Geometries: "))
tol = float(input("Enter the minimum spacing between atoms in (0.05-0.2) Angstrom: "))

def generate_geometry(dimensions, num_geometries, n, tol):
    geometries = {}
    for i in range(num_geometries):
        geometries[i] = {}
        for j in range(n):
            while True:
                # Generate coordinates based on dimensions (1D, 2D, or 3D)
                coords = tuple(random.uniform(0.000, 2 * n) if d < dimensions else 0 for d in range(3))
                # Check for minimum spacing condition
                if all(math.dist(coords, geometries[i][k]) >= tol for k in range(j)):
                    geometries[i][j] = coords
                    break
    return geometries

# Generate Geometries
G1 = generate_geometry(1, g1, n, tol)
G2 = generate_geometry(2, g2, n, tol)
G3 = generate_geometry(3, g3, n, tol)

def print_geometries(geometries, K, g, label):
    print(f"\n{label} Geometries are:")
    for i in range(g):
        print(f"\nGeometry {i + 1}:")
        q, l = 0, 0
        for j in range(n):
            print(f"\tatom  {geometries[i][j][0]:.3f}   {geometries[i][j][1]:.3f}   {geometries[i][j][2]:.3f}  {K[q]['symbol']}")
            l += 1
            if l == K[q]['count']:
                q += 1
                l = 0

# Printing the results
print_geometries(G1, K, g1, "One Dimensional")
print_geometries(G2, K, g2, "Two Dimensional")
print_geometries(G3, K, g3, "Three Dimensional")
