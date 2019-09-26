import numpy as NP
import func as MF
import math
m = MF.createMatrixByKeyboard()
print(m)
print("\n --------RESULTADOS--------")
print("\n   Apartado 4.1")
print("\n   ---> La moda es: "+str(MF.numpyCalMode(m)))
print("\n   Apartado 4.2")
print("\n   ---> La media es: "+str(NP.average(m)))


