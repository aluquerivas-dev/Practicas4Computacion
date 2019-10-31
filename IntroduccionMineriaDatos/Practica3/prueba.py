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
matrix_ccr = [['---',0,0,0,0],['KNN',0.0,0.0,0.0,0.0],['SVM',0.0,0.0,0.0,0.0],['DTC',0.0,0.0,0.0,0.0]]
matrix_error = [['---',0,0,0,0],['KNN',0.0,0.0,0.0,0.0],['SVM',0.0,0.0,0.0,0.0],['DTC',0.0,0.0,0.0,0.0]]
lista_datasets = listdir('./datasets/')
##Montar la matriz de CCR


c = 1
for i in lista_datasets:
    matrix_ccr[0][c] = i
    matrix_error[0][c] = i
    c = c + 1


lista_datasets = listdir('./datasets/')
AUX = 1
for indice in lista_datasets:

    dataset = arff.loadarff('./datasets/'+str(indice))
    df = pd.DataFrame(dataset[0])
    target = pd.factorize(df['class'])
    X_train,X_test,Y_train,Y_test=train_test_split(df.iloc[:, df.columns != 'class'],target[0], test_size=0.25)

    indice_aleatorio = random.randint(1, df.shape[0])
    patron_aleatorio = df.iloc[indice_aleatorio, df.columns != 'class']

    #Llamada y entrenamiento del algoritmo KNN
    print('|||||||||||||||||||||||||||||KNN||||||||||||||||||||||||||||||||||||')
    knn = KNeighborsClassifier(n_neighbors=25)
    knn.fit(X_train,Y_train)
    print('Porcentaje de bien clasificados KNN (\''+str(indice)+'\'): '+str(knn.score(X_test,Y_test)*100)+' %')
    print('Patron a clasificar del dataset('+str(indice_aleatorio)+')\n')
    matrix_ccr[1][AUX] = round(knn.score(X_test,Y_test),10)
    matrix_error[1][AUX] = round(1 - matrix_ccr[1][AUX],10)
    predecir(patron_aleatorio,knn)

    #Llamada y entrenamiento algoritmo SVM
    print('|||||||||||||||||||||||||||||SVM||||||||||||||||||||||||||||||||||||')
    svm = SVC(gamma='auto')
    svm.fit(X_train, Y_train)
    print('Porcentaje de bien clasificados SVM (\''+str(indice)+'\'): '+str(svm.score(X_test,Y_test)*100)+' %')
    print('Patron a clasificar del dataset(' + str(indice_aleatorio) + ')\n')
    matrix_ccr[2][AUX] = round(svm.score(X_test,Y_test),10)
    matrix_error[2][AUX] = round(1 - matrix_ccr[2][AUX],10)
    predecir(patron_aleatorio,svm)

    # Llamada y entrenamiento algoritmo DTC
    print('|||||||||||||||||||||||||||||DTC||||||||||||||||||||||||||||||||||||')
    dtc=DecisionTreeClassifier()
    dtc.fit(X_train, Y_train)
    print('Porcentaje de bien clasificados DTC (\'' + str(indice) + '\'): ' + str(dtc.score(X_test, Y_test) * 100) + ' %')
    print('Patron a clasificar del dataset(' + str(indice_aleatorio) + ')\n')
    matrix_ccr[3][AUX] = round(dtc.score(X_test,Y_test),10)
    matrix_error[3][AUX] = round(1 - matrix_ccr[3][AUX],10)
    predecir(patron_aleatorio, dtc)
    AUX = AUX + 1
print('\n\n\n')
print('CCR de las instancias: '+str(lista_datasets))
print(np.array(matrix_ccr))
print('\n\n\n')
print('Error de las instancias: '+str(lista_datasets))
print(np.array(matrix_error))

print('----------------------------GRAFICO COMPARATIVO CCR----------------------------')
fig = plt.figure(u'Gráfica de barras') # Figure
ax = fig.add_subplot(111) # Axes

x1 = ['K dia','K gla','K ion','K  iri']
y1 = [matrix_ccr[1][1],matrix_ccr[1][2],matrix_ccr[1][3],matrix_ccr[1][4]]
x2 = ['S dia','S gla','S ion','S  iri']
y2 = [matrix_ccr[2][1],matrix_ccr[2][2],matrix_ccr[2][3],matrix_ccr[2][4]]
x3 = ['D dia','D gla','D ion','D  iri']
y3 = [matrix_ccr[3][1],matrix_ccr[3][2],matrix_ccr[3][3],matrix_ccr[3][4]]


plt.bar(x1, y1, color='g',width=0.7, align='center')
plt.bar(x2, y2, color='b',width=0.7, align='center')
plt.bar(x3, y3, color='r',width=0.7, align='center')
plt.legend(['KNN','SVM','DTC'])
plt.title('GRAFICO COMPARATIVO CCR')
plt.show()
print('\n\n\n')


print('----------------------------GRAFICO COMPARATIVO ERROR----------------------------')
fig = plt.figure(u'Gráfica de barras') # Figure
ax = fig.add_subplot(111) # Axes

x1 = ['K dia','K gla','K ion','K  iri']
y1 = [matrix_error[1][1],matrix_error[1][2],matrix_error[1][3],matrix_error[1][4]]
x2 = ['S dia','S gla','S ion','S  iri']
y2 = [matrix_error[2][1],matrix_error[2][2],matrix_error[2][3],matrix_error[2][4]]
x3 = ['D dia','D gla','D ion','D  iri']
y3 = [matrix_error[3][1],matrix_error[3][2],matrix_error[3][3],matrix_error[3][4]]


plt.bar(x1, y1, color='g',width=0.7, align='center')
plt.bar(x2, y2, color='b',width=0.7, align='center')
plt.bar(x3, y3, color='r',width=0.7, align='center')
plt.legend(['KNN','SVM','DTC'])
plt.title('GRAFICO COMPARATIVO ERROR')
plt.show()