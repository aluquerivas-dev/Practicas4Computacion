import numpy as NP
import func as MF
import math
m = MF.createMatrixByKeyboard()
print("\n --------RESULTADOS--------")
print("\n   Apartado 3.1")
print(m)
for i in range(NP.size(m,1)):
    print("Valor maximo de la fila "+str(i)+": "+str(NP.max(m[i,:])))
    print("Valor minimo de la fila "+str(i)+": "+str(NP.min(m[i,:])))

for i in range(NP.size(m,0)):
    print("Valor maximo de la columna "+str(i)+": "+str(NP.max(m[:,i])))
    print("Valor minimo de la columna "+str(i)+": "+str(NP.min(m[:,i])))
print("\n   Apartado 3.2")

print("Determinante de la matriz: "+str(round(NP.linalg.det(m))))

print("\n   Apartado 3.3")

print("Rango de la matriz: "+str(NP.linalg.matrix_rank(m)))

