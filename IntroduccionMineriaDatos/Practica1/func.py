import numpy as NP
from scipy import stats as ST
def openMatrixFiledata(nameFile,deli):
	openFile = NP.loadtxt(nameFile, delimiter=deli)
	return openFile

def createMatrixByKeyboard():
    filas = int(input("\nFilas: "))
    columnas = int(input("\nColumnas: "))
    m = NP.zeros((filas, columnas))
    for i in range(filas):
    	for j in range(columnas):
       		dat = int(input("\nDato en ["+str(i)+"]["+str(j)+"]:"))
       		m[i][j]=dat
    return m

def numpyCalMode(matrix):
    aux=[]
    for i in range(NP.size(matrix,1)):
        for j in range(NP.size(matrix,0)):
            aux.append(matrix[i][j])  
    return ST.mode(aux)[0][0]