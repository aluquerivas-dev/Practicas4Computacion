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
dataset = arff.loadarff('./10vote.arff')
df = pd.DataFrame(dataset[0])
target = pd.factorize(df['class'])
X_train,X_test,Y_train,Y_test=train_test_split(df.iloc[:, df.columns != 'class'],target[0], test_size=0.25)


#Llamada y entrenamiento del algoritmo KNN
print('|||||||||||||||||||||||||||||KNN||||||||||||||||||||||||||||||||||||')
knn = KNeighborsClassifier(n_neighbors=2)
knn.fit(X_train,Y_train)
indice_aleatorio = random.randint(1, df.shape[0])
patron_aleatorio = df.iloc[indice_aleatorio, df.columns != 'class']
print(indice_aleatorio)
array = knn.predict([patron_aleatorio])
print('Clase predicha KNN')
print(target[1][array][0])
print('----------------')


#Llamada y entrenamiento algoritmo SVM
print('|||||||||||||||||||||||||||||SVM||||||||||||||||||||||||||||||||||||')
svm = SVC()
svm.fit(X_train, Y_train)
indice_aleatorio = random.randint(1, df.shape[0])
patron_aleatorio = df.iloc[indice_aleatorio, df.columns != 'class']
print(indice_aleatorio)
array = svm.predict([patron_aleatorio])
print('Clase predicha KNN')
print(target[1][array][0])
print('----------------')
#Llamada y entrenamiento algoritmo SVM
print('|||||||||||||||||||||||||||||SVM||||||||||||||||||||||||||||||||||||')
dtc = DecisionTreeClassifier()
dtc.fit(X_train, Y_train)
indice_aleatorio = random.randint(1, df.shape[0])
patron_aleatorio = df.iloc[indice_aleatorio, df.columns != 'class']
print(indice_aleatorio)
array = dtc.predict([patron_aleatorio])
print('Clase predicha KNN')
print(target[1][array][0])
print('----------------')
