import numpy as np
import sklearn
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import KFold
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier
from sklearn import metrics
import graphviz
from sklearn.tree import export_graphviz
import matplotlib.pyplot as plt
from sklearn.externals.six import StringIO
from IPython.display import Image
from sklearn.metrics import mean_squared_error
import pydotplus
from scipy.io import arff
import pandas as pd
from os import listdir
import random
def predecir(aux,clasificador):
    array = clasificador.predict([aux])
    print('Clase predicha KNN')
    print(target[1][array][0])
    print('----------------')



#MAIN
matrix_ccr = np.array([('   ','','','',''),('KNN',1.0,0.0,0.0,0.0),('SVM',2.0,0.0,0.0,0.0),('DTC',3.0,0.0,0.0,0.0)])
matrix_mse = np.array([('   ','','','',''),('KNN',1.0,0.0,0.0,0.0),('SVM',2.0,0.0,0.0,0.0),('DTC',3.0,0.0,0.0,0.0)])
lista_datasets = listdir('./datasets/')
##Montar la matriz de CCR
c = 1
for i in lista_datasets:
    matrix_ccr[0][c] = i
    matrix_mse[0][c] = i
    c = c + 1
print(matrix_ccr)
print(matrix_mse)
lista_datasets = listdir('./datasets/')
AUX = 1
for indice in lista_datasets:

    dataset = arff.loadarff('./datasets/'+str(indice))
    df = pd.DataFrame(dataset[0])
    target = pd.factorize(df['class'])
    X_train,X_test,Y_train,Y_test=train_test_split(df.iloc[:, df.columns != 'class'],target[0], test_size=0.4)

    indice_aleatorio = random.randint(1, df.shape[0])
    patron_aleatorio = df.iloc[indice_aleatorio, df.columns != 'class']

    #Llamada y entrenamiento del algoritmo KNN
    print('|||||||||||||||||||||||||||||KNN||||||||||||||||||||||||||||||||||||')
    knn = KNeighborsClassifier(n_neighbors=25)
    knn.fit(X_train,Y_train)
    print('Porcentaje de bien clasificados KNN (\''+str(indice)+'\'): '+str(knn.score(X_test,Y_test)*100)+' %')
    print('Patron a clasificar del dataset('+str(indice_aleatorio)+')\n')
    matrix_ccr[1][AUX] = knn.score(X_test,Y_test)
    matrix_mse[1][AUX] = 1.0-knn.score(X_test,Y_test)
    predecir(patron_aleatorio,knn)

    #Llamada y entrenamiento algoritmo SVM
    print('|||||||||||||||||||||||||||||SVM||||||||||||||||||||||||||||||||||||')
    svm = SVC(gamma='auto')
    svm.fit(X_train, Y_train)
    print('Porcentaje de bien clasificados SVM (\''+str(indice)+'\'): '+str(svm.score(X_test,Y_test)*100)+' %')
    print('Patron a clasificar del dataset(' + str(indice_aleatorio) + ')\n')
    matrix_ccr[2][AUX] = svm.score(X_test,Y_test)
    matrix_mse[2][AUX] = 1.0-svm.score(X_test,Y_test)
    predecir(patron_aleatorio,svm)

    # Llamada y entrenamiento algoritmo DTC
    print('|||||||||||||||||||||||||||||DTC||||||||||||||||||||||||||||||||||||')
    dtc=DecisionTreeClassifier()
    dtc.fit(X_train, Y_train)
    print('Porcentaje de bien clasificados DTC (\'' + str(indice) + '\'): ' + str(dtc.score(X_test, Y_test) * 100) + ' %')
    print('Patron a clasificar del dataset(' + str(indice_aleatorio) + ')\n')
    matrix_ccr[3][AUX] = dtc.score(X_test, Y_test)
    matrix_mse[3][AUX] = 1.0-dtc.score(X_test, Y_test)
    predecir(patron_aleatorio, dtc)
    AUX = AUX + 1

print(matrix_ccr)
print(matrix_mse)

