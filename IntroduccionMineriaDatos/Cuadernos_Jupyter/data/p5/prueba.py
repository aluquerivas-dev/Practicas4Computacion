# -*- coding: utf-8 -*-
from scipy.io import arff
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
from os import listdir
from sklearn.svm import LinearSVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.multiclass import OutputCodeClassifier
import warnings
warnings.filterwarnings('ignore')

lista_datasets=listdir('./datasets')

def base():

    print('CLASIFICADOR BASE LINEARSVC')

    for indice in lista_datasets:
        print('Base de datos: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])
        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        X_train, X_test, Y_train, Y_test = train_test_split(input, output, test_size=0.25)
        # llamada y entrenamiento algoritmo SVM

        svc = LinearSVC(random_state=0, tol=1e-5, max_iter=500)

        svc.fit(X_train, Y_train)

        print('Porcentaje de bien clasificados LINEARSVC')

        print(svc.score(X_test, Y_test))

    print('--------------------------')

def OVA_OVO(param):

    print('Aplicando metodo multiclase ONE VS ALL GAUSSIAN PROCESS CLASSIFIER')

    for i in lista_datasets:
        print('Base de datos: ' + str(i))
        dataset = arff.loadarff('./datasets/' + str(i))
        df = pd.DataFrame(dataset[0])
        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]

        X_train, X_test, Y_train, Y_test = train_test_split(input, output, test_size=0.25)

        kernel = ( 1.0 * RBF(1.0) )

        gpc = GaussianProcessClassifier(kernel=kernel, random_state=0, multi_class=param)
        gpc.fit(X_train, Y_train)
        print('Porcentaje de bien clasificados GAUSSIAN PROCESS CLASSIFIER ONE VS ALL')
        print(gpc.score(X_test, Y_test))

    print('--------------------------')

def ECOC():

    print('Aplicando metodo multiclase ERROR CORRECTING OUTPUT CODES')
    for indice in lista_datasets:

        print('Base de datos: ' + str(indice))
        dataset = arff.loadarff('./datasets/' + str(indice))
        df = pd.DataFrame(dataset[0])
        input = df.iloc[:, df.columns != 'class']
        output = pd.factorize(df['class'])[0]
        X_train, X_test, Y_train, Y_test = train_test_split(input, output, test_size=0.25)

        clf = OutputCodeClassifier(KNeighborsClassifier(n_neighbors=5), code_size=2, random_state=0)
        clf.fit(X_train, Y_train)

        print('Porcentaje de bien clasificados ERROR CORRECTING OUTPUT CODES')
        print(clf.score(X_test, Y_test))
    print('--------------------------')
if __name__ == '__main__':



    value = input('Metodos disponibles: \n \t\t -> (base) Aplicar metodo base \n \t\t -> (OVO) Aplicar Bagging \n \t\t -> (OVA) Aplicar Boosting Regresion \n \t\t -> (ECOC) Aplicar Boosting Clasificacion \n\n\n\n')
    # Obten la función del diccionario

    if value == 'base':
        base()
    if value == 'OVO':
        OVA_OVO('one_vs_one')
    if value == 'OVA':
        OVA_OVO('one_vs_rest')
    if value == 'ECOC':
        ECOC()