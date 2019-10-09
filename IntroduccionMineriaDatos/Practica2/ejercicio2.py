from scipy.io import arff
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
IRIS = arff.loadarff('iris.arff')
DIABETES = arff.loadarff('diabetes.arff')
TIEMPO = arff.loadarff('weather.arff')

#Pintamos IRIS
df1 = pd.DataFrame(IRIS[0])
df1.plot.hist(bins=12, alpha=0.5,by=4)
plt.suptitle('Histograma de dataset iris.arff')


#Pintamos DIABETES
df2 = pd.DataFrame(DIABETES[0])
df2.plot.hist(bins=12, alpha=0.5,by=4)
plt.suptitle('Histograma de dataset diabetes.arff')


#Pintamos TIEMPO
df3 = pd.DataFrame(TIEMPO[0])
df3.plot.hist(bins=12, alpha=0.5,by=4,label='Short label')

plt.suptitle('Histograma de dataset weather.arff')
plt.show()


