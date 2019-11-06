import click
from sklearn.metrics import accuracy_score

if __name__ == '__main__':
    score = accuracy_score([1,2,4,4,5],[1,2,3,4,5])
    print(score)