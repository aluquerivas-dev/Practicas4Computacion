from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import MinMaxScaler
def principal():
    digits=load_digits()

    #DIvidimos en conjunto de test y train
    train_inputs,test_inputs,train_outputs,test_outputs=train_test_split(digits['data'],digits['target'])
    scaler=MinMaxScaler()
    scaler.fit(train_inputs)
    scaler.fit(test_inputs)

    #Algoritmo KNN para vecinos
    print('------------Ejecutando KNN para i vecinos---------')
    for i in range(1,5):
        print('Vecinos: ',i)
        knn = KNeighborsClassifier(n_neighbors=i)
        knn.fit(train_inputs,train_outputs)
        print('CCR Train')
        print(knn.score(train_inputs,train_outputs))
        print('CCR Test')
        print(knn.score(test_inputs,test_outputs))
        print('|@')

    #Para problemas multiclase utilizamos newton-cg y multiclass ovr para que se entrene un poblema binario para cada clase
    logreg = LogisticRegression(random_state=0, solver='newton-cg',multi_class='ovr', max_iter=500)
    logreg.fit(train_inputs, train_outputs)
    print('CCR Train')
    print(logreg.score(train_inputs, train_outputs))
    print('CCR Test')
    print(logreg.score(test_inputs, test_outputs))
    print('-------------------')

if __name__ == "__main__":
    principal()