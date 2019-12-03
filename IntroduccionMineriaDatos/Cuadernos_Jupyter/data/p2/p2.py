import plotly.express as px
iris = px.data.iris()
fig = px.scatter_matrix(iris)
fig.show()