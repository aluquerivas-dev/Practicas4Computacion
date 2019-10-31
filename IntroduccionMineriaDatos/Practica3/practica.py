#-*- coding: utf-8 -*-
import matplotlib.pyplot as plt

fig = plt.figure(u'Gráfica de barras') # Figure
ax = fig.add_subplot(111) # Axes

x1 = ['K dia','K gla','K ion','K  iri']
y1 = [15,40,80,45]
x2 = ['S dia','S gla','S ion','S  iri']
y2 = [23,32,56,90]
x3 = ['D dia','D gla','D ion','D  iri']
y3 = [3,64,75,90]


plt.bar(x1, y1, color='g',width=0.7, align='center')
plt.bar(x2, y2, color='b',width=0.7, align='center')
plt.bar(x3, y3, color='r',width=0.7, align='center')
plt.legend(['KNN','SVM','DTC'])
plt.show()