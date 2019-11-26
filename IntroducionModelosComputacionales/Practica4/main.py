import numpy as np
import pandas as pd
from sklearn import svm
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.svm import SVC
import time

time_start = time.perf_counter()
data_train = pd.read_csv('./BasesDatos/csv/train_spam.csv', header=None)
data_test = pd.read_csv('./BasesDatos/csv/test_spam.csv', header=None)
vocabulario = pd.read_csv('./etiquetasYVocabulario/vocab.txt', header=None,delimiter='\t')
vocabulario = vocabulario.iloc[:,-1]

train_inputs = data_train.iloc[:, :-1].values
train_outputs = data_train.iloc[:, -1].values

test_inputs = data_test.iloc[:, :-1].values
test_outputs = data_test.iloc[:, -1].values

SVM = svm.SVC(kernel='linear', C=0.1)
SVM.fit(train_inputs, train_outputs)
Y_pred = SVM.predict(test_inputs)
time_elapsed = (time.perf_counter() - time_start)

print("%5.1f segundos" % (time_elapsed))

print('Valor de score: ' + str(accuracy_score(test_outputs, Y_pred)))

print(confusion_matrix(test_outputs,Y_pred))


CONTADOR = 1
for etiqueta_real, etiqueta_predicha in zip(test_outputs, Y_pred):
    if etiqueta_real!= etiqueta_predicha:
        print('Correo Mal Predicho: '+str(CONTADOR))
        C=0
        for i in (test_inputs[CONTADOR,:]):
            if(i==1):
                print('\t\t\tPalabra['+str(C)+']: '+str(vocabulario[C]))
            C=C+1
    CONTADOR=CONTADOR+1