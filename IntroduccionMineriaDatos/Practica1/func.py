import numpy as NP
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

	