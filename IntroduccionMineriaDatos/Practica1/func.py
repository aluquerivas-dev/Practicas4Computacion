import numpy as NP
def openMatrixFiledata(nameFile,deli):
	openFile = NP.loadtxt(nameFile, delimiter=deli)
	return openFile