
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
dataset = arff.loadarff('./datasets/iris.arff')
df = pd.DataFrame(dataset[0])
target = pd.factorize(df['class'])

X_train,X_test,Y_train,Y_test=train_test_split(df.iloc[:, df.columns != 'class'],target[0], test_size=0.4)

#Llamada y entrenamiento del algoritmo KNN
knn=KNeighborsClassifier(n_neighbors=25)
knn.fit(X_train,Y_train)
print('Porcentaje de bien clasificados KNN:')
print(knn.score(X_test,Y_test))
array=knn.predict([[5.2,3.4,1.6,1.1]])
print('Clase predicha KNN')
print(target[1][array][0])

print('----------------')
