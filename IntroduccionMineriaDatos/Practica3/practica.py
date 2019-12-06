# -*- coding: utf-8 -*-
from scipy.io import arff
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier
import pandas as pd
from sklearn.metrics import mean_squared_error
from scipy.stats import wilcoxon
from os import listdir
import numpy as np
from scipy.stats import friedmanchisquare
from scipy.stats import rankdata
from sklearn.model_selection import cross_val_score
from sklearn.ensemble import bagging
from sklearn import model_selection
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import GradientBoostingRegressor

lista_datasets=listdir('./datasets')

def base():
    print('Aplicando método base: ')
    for indice in lista_datasets:
        print('Dataset: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])

        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        # Llamada y entrenamiento del algoritmo KNN
        print('Puntuacion KNN')
        knn = KNeighborsClassifier(n_neighbors=5)
        cv_scores = cross_val_score(knn, input, output, cv=3)
        print(cv_scores)
        print('----------------')
        # llamada y entrenamiento algoritmo SVM
        print('Puntuacion SVM')
        svm = SVC(gamma='auto')
        cv_scores = cross_val_score(svm, input, output, cv=3)
        print(cv_scores)
        print('-----------------')
        # llamada y entrenamiento del arbol de decision
        print('Puntuacion TREE')
        arbol = DecisionTreeClassifier()
        cv_scores = cross_val_score(arbol, input, output, cv=3)
        print(cv_scores)
        print('-----------------------------------------------')

def bagging():
    print('Aplicando metodo de combinacion BAGGING')
    for indice in lista_datasets:
        print('Dataset: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])

        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        for ESTIMADOR_BASE in [KNeighborsClassifier(n_neighbors=5), SVC(gamma='auto'), DecisionTreeClassifier()]:
            kfold = model_selection.KFold(n_splits=3)
            model = bagging.BaggingClassifier(base_estimator=ESTIMADOR_BASE)
            results = model_selection.cross_val_score(model, input, output, cv=kfold)
            print(results)

def boosting_r():
    print('Algoritmo de BOOSTING: Regressor')
    for indice in lista_datasets:
        print('Dataset: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])

        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        kfold = model_selection.KFold(n_splits=10)

        model = GradientBoostingRegressor(n_estimators=100, learning_rate=0.1, max_depth=1, random_state=0, loss='ls')
        RE = model_selection.cross_val_score(model, input, output, cv=kfold)

        print(RE)

def boosting_c():
    print('Algoritmo de BOOSTING: Classifier')
    for indice in lista_datasets:
        print('Dataset: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])

        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        kfold = model_selection.KFold(n_splits=3)

        model = GradientBoostingClassifier(n_estimators=100, learning_rate=1.0, max_depth=1, random_state=0)
        RE = model_selection.cross_val_score(model, input, output, cv=kfold)

        print(RE)


if __name__ == '__main__':



    value = input('Metodos disponibles: \n \t\t -> (base) Aplicar metodo base \n \t\t -> (bagging) Aplicar Bagging \n \t\t -> (boosting_r) Aplicar Boosting Regresion \n \t\t -> (boosting_c) Aplicar Boosting Clasificacion')
    # Obten la función del diccionario

    if value == 'base':
        base()
    if value == 'bagging':
        bagging()
    if value == 'boosting_r':
        boosting_r()
    if value == 'boosting_c':
        boosting_c()

