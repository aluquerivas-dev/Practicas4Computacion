
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
import pydotplus
from scipy.io import arff
import pandas as pd
from os import listdir
def predecir(aux):
    array = knn.predict([aux])
    print('Clase predicha KNN')
    print(target[1][array][0])
    print('----------------')

lista_datasets = listdir('./datasets/')
print(lista_datasets)
for indice in lista_datasets:

    dataset = arff.loadarff('./datasets/'+str(indice))
    df = pd.DataFrame(dataset[0])
    target = pd.factorize(df['class'])

    X_train,X_test,Y_train,Y_test=train_test_split(df.iloc[:, df.columns != 'class'],target[0], test_size=0.4)

    #Llamada y entrenamiento del algoritmo KNN
    knn=KNeighborsClassifier(n_neighbors=25)
    knn.fit(X_train,Y_train)
    print('Porcentaje de bien clasificados KNN (\''+str(indice)+'\'):')
    print(str(knn.score(X_test,Y_test)*100)+'%')

    if (indice == 'iris.arff'):
        aux=[5.1, 3.5, 1.4, 0.2]
        predecir(aux)

    if (indice == 'cpu.arff'):
        aux=[23,16000,32000,64,16,32]
        predecir(aux)

    if (indice == 'diabetes.arff'):
        aux=[6,148,72,35,0,33.6,0.627,50]
        predecir(aux)

    if (indice == 'glass.arff'):
        aux=[1.51689,12.67,2.88,1.71,73.21,0.73,8.54,0,0]
        predecir(aux)

    if (indice == 'ionosphere.arff'):
        aux=[1,0,0.99539,-0.05889,0.85243,0.02306,0.83398,-0.37708,1,0.03760,0.85243,-0.17755,0.59755,-0.44945,0.60536,-0.38223,0.84356,-0.38542,0.58212,-0.32192,0.56971,-0.29674,0.36946,-0.47357,0.56811,-0.51171,0.41078,-0.46168,0.21266,-0.34090,0.42267,-0.54487,0.18641,-0.45300]
        predecir(aux)

