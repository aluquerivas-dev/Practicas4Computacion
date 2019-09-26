import numpy as NP
import func as MF
import math
#m = MF.openMatrixFiledata("datos.txt"," ")
m = MF.createMatrixByKeyboard()
print("\n --------RESULTADOS--------")
print("\n   Apartado 2.1")
print("\n   ---> Valor maximo: "+str(m.max()))
print("\n   ---> Valor minimo: "+str(m.min()))
print("\n   Apartado 2.2")
print(m)
flag = 0
aux=[]
while flag!=2:
    
    opt = int(input("\n (1) Para selecionar una fila, (2) Para seleccionar una columna: "))

    if opt == 1:
        value = int(input("\n Introduce la fila a calcular: "))
        aux.append(m[value,:])
        flag=flag+1    
    elif opt ==2:
        value = int(input("\n Introduce la columna a calcular: "))
        aux.append(m[:,value])
        flag=flag+1
    else:
        print("\nValor incorrecto")

numerador = NP.dot(aux[0], aux[1])
denominador = (NP.linalg.norm(aux[0])*NP.linalg.norm(aux[1]))
print("El angulo en radianes es: "+str(numerador/denominador)+"")
print("El angulo en grados es: "+str((NP.arccos(numerador/denominador) * 180 / math.pi))+"")


