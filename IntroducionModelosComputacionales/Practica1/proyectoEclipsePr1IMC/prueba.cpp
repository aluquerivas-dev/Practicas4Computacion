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
	ficheroEntrada.close();
	std::cout<< "Puntero:" << int(*data);
	/*
	getline(ficheroEntrada, firstLine);
 	ficheroEntrada.close();
 	std::cout << "Frase leida: " << firstLine << std::endl;
 	*/
}