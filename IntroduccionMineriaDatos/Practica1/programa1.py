import numpy as NP
import func as MF
m = MF.openMatrixFiledata("datos.txt"," ")
m = m[::-1]#Damos la vuelta a la matriz por columnas

print(m)

