import numpy as np
import pandas as pd
from sklearn import svm
from sklearn.metrics import accuracy_score
from sklearn.model_selection import StratifiedShuffleSplit, GridSearchCV
from sklearn.svm import SVC
import time
for C in [0.01,0.1,1,10]:
    time_start = time.perf_counter()
    optimo = svm.SVC(kernel='rbf',C=C,gamma='auto')
    data_train = pd.read_csv('./BasesDatos/csv/train_spam.csv',header=None)
    data_test = pd.read_csv('./BasesDatos/csv/test_spam.csv',header=None)

    train_inputs = data_train.iloc[:,:-1].values
    train_outputs = data_train.iloc[:,-1].values

    test_inputs = data_test.iloc[:,:-1].values
    test_outputs = data_test.iloc[:,-1].values

    optimo.fit(train_inputs, train_outputs)
    Y_pred = optimo.predict(test_inputs)
    time_elapsed = (time.perf_counter() - time_start)
    print("%5.1f segundos" % (time_elapsed))
    print('Valor de C: ' + str(C))
    print('Valor de score: '+str(accuracy_score(test_outputs, Y_pred)))
