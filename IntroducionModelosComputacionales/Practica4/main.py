import numpy as np
import pandas as pd
from sklearn import svm
from sklearn.metrics import accuracy_score
from sklearn.model_selection import StratifiedShuffleSplit, GridSearchCV
from sklearn.svm import SVC
import warnings
warnings.filterwarnings('ignore')
warnings.filterwarnings(action='ignore',category=DeprecationWarning)
warnings.filterwarnings(action='ignore',category=FutureWarning)

tuned_parameters = [{
                    'kernel': ['rbf'],
                    'gamma': np.logspace(-15, 3, num=9, base=2),
                     'C': np.logspace(-5, 15, num=11, base=2)
                    }]
optimo = GridSearchCV(estimator=svm.SVC(kernel='rbf'),param_grid=tuned_parameters, n_jobs=-1, cv=5)


data = pd.read_csv('./BasesDatos/csv/dataset3.csv',header=None)

inputs = data.iloc[:,:-1].values
outputs = data.iloc[:,-1].values

SSS = StratifiedShuffleSplit(n_splits=10, test_size=0.25,train_size=0.75)
#En SSS.split guardamos todos los split aleatorios del dataset, usamos un for para si fuera de mas de 1 split.
SPLIT = 1
C_ARRAY = []
G_ARRAY = []
for train_index, test_index in SSS.split(inputs, outputs):
    X_train, X_test = inputs[train_index], inputs[test_index]
    Y_train, Y_test = outputs[train_index], outputs[test_index]

    optimo.fit(X_train, Y_train)
    Y_pred = optimo.predict(X_test)
    print('Valor de C: '+str(optimo.best_params_['C']))
    print('Valor de GAMMA: '+str(optimo.best_params_['gamma']))
    print('Valor de score: '+str(accuracy_score(Y_test, Y_pred)))
    C_ARRAY.append(optimo.best_params_['C'])
    G_ARRAY.append(optimo.best_params_['gamma'])

print("Parametro 'C' estimado medio: "+str(np.mean(C_ARRAY)))
print("Parametro 'gamma' estimado medio: "+str(np.mean(G_ARRAY)))