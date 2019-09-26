import numpy as NP
import func as MF
import math
file = raw_input("\n Inserte el nombre del fichero: ")
delimiter = raw_input("\n Inserte el delimitador del fichero: ")

m = MF.openMatrixFiledata(file,delimiter)
print("\n --------Matrix Leida--------")
print(m)
print("\n --------RESULTADOS--------")
inversa = NP.linalg.inv(m)
print("\n   ---> Inversa: ")
print(inversa)
print("\n   ---> Producto m*m-1: ")
multi = NP.matmul(m,inversa)
print(multi)

indentidad = NP.identity(NP.size(m,1))
if NP.array_equal(indentidad,multi)==True:
    print("Es correcto\n")




