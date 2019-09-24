#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>  // Para establecer la semilla srand() y generar números aleatorios rand()
#include <limits>
#include <math.h>
struct Datos {
	int nNumEntradas;     /* Número de entradas */
	int nNumSalidas;      /* Número de salidas */
	int nNumPatrones;     /* Número de patrones */
	double** entradas;    /* Matriz con las entradas del problema */
	double** salidas;     /* Matriz con las salidas del problema */
};
int main(int argc, char const *argv[])
{
	struct Datos data;
	
	std::ifstream ficheroEntrada;
	ficheroEntrada.open("train_sin.dat");
	std::cout<<"Hola1\n";
	ficheroEntrada >> data.nNumEntradas;
	std::cout<<"Hola1\n";
	ficheroEntrada >> data.nNumSalidas;
	std::cout<<"Hola1\n";
	ficheroEntrada >> data.nNumPatrones;
	std::cout<<"Entradas:" << data.nNumEntradas<< std::endl;
	std::cout<<"Salidas:" << data.nNumSalidas<< std::endl;
	std::cout<<"Patrones:" << data.nNumPatrones<< std::endl;
	
	data.entradas = (double **)malloc (data.nNumPatrones*sizeof(double *));

	for (int i=0;i<data.nNumPatrones;i++)//Entradas
		data.entradas[i] = (double *) malloc (data.nNumEntradas*sizeof(double));

	data.salidas = (double **)malloc (data.nNumPatrones*sizeof(double *));

	for (int i=0;i<data.nNumPatrones;i++)//Salidas
		data.salidas[i] = (double *) malloc (data.nNumSalidas*sizeof(double));
	//Rellenamos matriz de entrada y salida de datos.
   int i = 0;
   int j = 0;
   int linea=0;
   while (!ficheroEntrada.eof())
   {
      
	 for(int x = 0; x < data.nNumEntradas; x++)
	 {
		 ficheroEntrada >> data.entradas[i][x];
		 std::cout<<"Linea("<<linea<<"): "<<data.entradas[j][x];
	 }
	 for(int y = 0; y < data.nNumEntradas; y++)
	 {
		 ficheroEntrada >> data.salidas[j][y];
		 std::cout<<" "<<data.entradas[j][y];
		 
	 }
	 std::cout<<"\n";
      
      i++;
	  j++;
	  linea++;
   }
   std::cout<<"hola\n";
   ficheroEntrada.close(); 
   }
