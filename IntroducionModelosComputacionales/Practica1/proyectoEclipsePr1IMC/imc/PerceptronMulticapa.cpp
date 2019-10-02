/*********************************************************************
* File : PerceptronMulticapa.cpp
* Date : 2018
*********************************************************************/

#include "PerceptronMulticapa.h"
#include "util.h"


#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>  // Para establecer la semilla srand() y generar números aleatorios rand()
#include <limits>
#include <math.h>


using namespace imc;
using namespace std;
using namespace util;

// ------------------------------
// CONSTRUCTOR: Dar valor por defecto a todos los parámetros
PerceptronMulticapa::PerceptronMulticapa(){
	dEta = 0.1;
	dMu = 0.9;
	nNumCapas = 3;

}

// ------------------------------
// Reservar memoria para las estructuras de datos
void PerceptronMulticapa::inicializar(int nl, int npl[]) {
	nNumCapas = nl;
	//Reservamos memoria para el vector que tendra las capas.
	pCapas = (Capa *)calloc(nl,sizeof(Capa));
	//Primera capa con el numero de neuronas y su reserva de memoria, es la unica que no dispondra de sesgo.
	pCapas[0].nNumNeuronas = npl[0];
	pCapas[0].pNeuronas = (Neurona *)calloc(npl[0],sizeof(Neurona));

	int TEMP = 0;
	int sesgo = 1;
	for(int i = 1; i <nl; i++)//Bucle que usaremos para iniciar las i capas ocultas
	{	
		pCapas[i].nNumNeuronas = npl[i];
		pCapas[i].pNeuronas = (Neurona *)calloc(npl[i],sizeof(Neurona));
			
			for(int j = 0; j < pCapas[i].nNumNeuronas; j++)//Bucle que usaremos para iniciar el tamaño de la capa oculta i
			{
				// En temp se guarda el numero de neuronas+sesgo de la cada capa oculta i.
				//Si por ejemplo estamos en la capa oculta numero 1 
				//esta tendra sus vectores de pesos a NumdeEntradas+1(+1 del Sesgo)
				TEMP = npl[i-1]+sesgo;
				pCapas[i].pNeuronas[j].w = (double*)calloc(TEMP,sizeof(double));           
				pCapas[i].pNeuronas[j].deltaW = (double*)calloc(TEMP,sizeof(double));        
				pCapas[i].pNeuronas[j].ultimoDeltaW = (double*)calloc(TEMP,sizeof(double));  
				pCapas[i].pNeuronas[j].wCopia = (double*)calloc(TEMP,sizeof(double)); 

					
					for(int k = 0; k < TEMP; k++)//Bucle que usaremos para iniciar el valor de la capa oculta i
					{
						pCapas[i].pNeuronas[j].w[k] = 0.0;           
						pCapas[i].pNeuronas[j].deltaW[k] = 0.0;        
						pCapas[i].pNeuronas[j].ultimoDeltaW[k] = 0.0;  
						pCapas[i].pNeuronas[j].wCopia[k] = 0.0; 
					}
					
			}
			TEMP = 0;
			//Reiniciamos el temporal por si acaso se quedan datos basura.
			
	}
	
}


// ------------------------------
// DESTRUCTOR: liberar memoria
PerceptronMulticapa::~PerceptronMulticapa() {
	liberarMemoria();

}


// ------------------------------
// Liberar memoria para las estructuras de datos
void PerceptronMulticapa::liberarMemoria() {

	for(int i = 0;i<nNumCapas;i++){
		//Vamos recorriendo todas las capas i para liberar memoria
		for(int j = 0;j<pCapas[i].nNumNeuronas;j++)
		{
			if(i!=0){//La primera capa no tiene inicializado ningun vector puesto que no hay neuronas predecesoras
			//Cada capa tiene un array de neuronas, las recorremos con j y liberamos cada vector
			free(pCapas[i].pNeuronas[j].w);
			free(pCapas[i].pNeuronas[j].deltaW);
			free(pCapas[i].pNeuronas[j].ultimoDeltaW);
			free(pCapas[i].pNeuronas[j].wCopia);
			}
		}
		//Se libera el vector de neuronas de la capa i
		free(pCapas[i].pNeuronas);
	}
	//Se livera el vector de capas
	free(pCapas);

}

// ------------------------------
// Rellenar todos los pesos (w) aleatoriamente entre -1 y 1
void PerceptronMulticapa::pesosAleatorios() {

	

	for(int i = 1; i <nNumCapas; i++)
	{	
	//Recorremos las capas desde la 1 hasta la nNumcapas
	//La capa 1 no tiene conexiones anteriores por ello no se inicalizan datos.		
		for(int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
		//Cada capa tiene un vector de neuronas donde cada una tiene un vector de pesos
		//pCapas[i-1].nNumNeuronas+1 guarda la cantidad de neuronas de la capa anterior + el sesgo
					
			for(int k = 0; k < pCapas[i-1].nNumNeuronas+1; k++)//Bucle que usaremos para iniciar el valor de la capa oculta i
			{
			//Por cada neurona j de la capa i recorremos con k los vectores de pesos w y su copia
			//Metemos valores aleatorios en estos arrays.
				double X = (double)rand() / RAND_MAX;
    			double Y = (-1.0) + X * ((1.0) - (-1.0));
				pCapas[i].pNeuronas[j].w[k] = Y;           
				pCapas[i].pNeuronas[j].wCopia[k] = Y; 
			}
					
			}
			
	}

}

// ------------------------------
// Alimentar las neuronas de entrada de la red con un patrón pasado como argumento
void PerceptronMulticapa::alimentarEntradas(double* input) {

	for (int i = 0; i <pCapas[0].nNumNeuronas; i++)
	{
		pCapas[0].pNeuronas[i].x=input[i];
	}
	
}

// ------------------------------
// Recoger los valores predichos por la red (out de la capa de salida) y almacenarlos en el vector pasado como argumento
void PerceptronMulticapa::recogerSalidas(double* output)
{
	//La ultima capa es la nNumCapas-1
	for (int i = 0; i < pCapas[nNumCapas-1].nNumNeuronas; i++)
	{
		//Recogemos los valores out de la ultima capa por cada una de sus neuronas
		output[i] = pCapas[nNumCapas-1].pNeuronas[i].x;
	}
	

}

// ------------------------------
// Hacer una copia de todos los pesos (copiar w en copiaW)
void PerceptronMulticapa::copiarPesos() {

	for(int i = 1; i <nNumCapas; i++)
	{	
	//Recorremos las capas desde la 1 hasta la nNumcapas
	//La capa 1 no tiene conexiones anteriores por ello no se inicalizan datos.		
		for(int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
		//Cada capa tiene un vector de neuronas donde cada una tiene un vector de pesos
		//pCapas[i-1].nNumNeuronas+1 guarda la cantidad de neuronas de la capa anterior + el sesgo
					
			for(int k = 0; k < pCapas[i-1].nNumNeuronas+1; k++)//Bucle que usaremos para iniciar el valor de la capa oculta i
			{
				//Por cada neurona j de la capa i recorremos con k los vectores de pesos w y su copia
				//Metemos valores de w en copia por si hace falta restaurar.
				pCapas[i].pNeuronas[j].wCopia[k] = pCapas[i].pNeuronas[j].w[k]; 
			}
					
			}
			
	}

}

// ------------------------------
// Restaurar una copia de todos los pesos (copiar copiaW en w)
void PerceptronMulticapa::restaurarPesos() {
	for(int i = 1; i <nNumCapas; i++)
	{	
	//Recorremos las capas desde la 1 hasta la nNumcapas
	//La capa 1 no tiene conexiones anteriores por ello no se inicalizan datos.		
		for(int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
		//Cada capa tiene un vector de neuronas donde cada una tiene un vector de pesos
		//pCapas[i-1].nNumNeuronas+1 guarda la cantidad de neuronas de la capa anterior + el sesgo
					
			for(int k = 0; k < pCapas[i-1].nNumNeuronas+1; k++)//Bucle que usaremos para iniciar el valor de la capa oculta i
			{
				//Por cada neurona j de la capa i recorremos con k los vectores de pesos w y su copia
				//Metemos valores de copia en w para su restauracion.
				pCapas[i].pNeuronas[j].w[k] = pCapas[i].pNeuronas[j].wCopia[k];
			}
					
			}
			
	}

}

// ------------------------------
// Calcular y propagar las salidas de las neuronas, desde la primera capa hasta la última
void PerceptronMulticapa::propagarEntradas() {
	double c=0.0;
	for (int i = 1; i <nNumCapas; i++)
	{
		
		for (int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
		
			//pCapas[i-1].nNumNeuronas+1 , simboliza capa anterior y su sesgo que es el +1
			//Este bucle recorre la capa anterior a i, i-1
			for (int k = 1; k < pCapas[i-1].nNumNeuronas+1; k++)
			{
				//cout<<"Neurona capa anterior: "<<pCapas[i-1].nNumNeuronas<<"\n";
				// [k-1].x , porque de la capa anterior tenemos que empezar por la neurona 0
				// pNeuronas[j].w[k] , porque en la capa i la neurona j su peso w[0] es el sesgo y no se tiene en cuenta
		
				c += pCapas[i-1].pNeuronas[k-1].x*pCapas[i].pNeuronas[j].w[k];

			}
			//SESGO
			c += pCapas[i].pNeuronas[j].w[0];

			pCapas[i].pNeuronas[j].x = (1/(1 + exp((-1)*c)));
			c = 0.0;
		}
		
		
	}
	
	
}

// ------------------------------
// Calcular el error de salida (MSE) del out de la capa de salida con respecto a un vector objetivo y devolverlo
double PerceptronMulticapa::calcularErrorSalida(double* target) {

	double MSE=0.0;
	//nNumCapas-1, por que la notacion vector es tenemos 5 capas pero en vector es la capa 4

	for (int i = 0; i<pCapas[nNumCapas-1].nNumNeuronas; i++)
	{

		MSE += pow(target[i] - pCapas[nNumCapas-1].pNeuronas[i].x, 2);
	}
	MSE=MSE/pCapas[nNumCapas-1].nNumNeuronas;
	return MSE;
}


// ------------------------------
// Retropropagar el error de salida con respecto a un vector pasado como argumento, desde la última capa hasta la primera
void PerceptronMulticapa::retropropagarError(double* objetivo) {
	double C = 0.0;

	for(int i=0; i<pCapas[nNumCapas-1].nNumNeuronas; i++)
	{
		pCapas[nNumCapas-1].pNeuronas[i].dX =  (-1)*(objetivo[i] - pCapas[nNumCapas-1].pNeuronas[i].x) * pCapas[nNumCapas-1].pNeuronas[i].x * (1 - pCapas[nNumCapas-1].pNeuronas[i].x);
	}


	for(int i=nNumCapas-2; i>=0; i--)
	{
		for(int j=0; j<pCapas[i].nNumNeuronas; j++)
		{
			//Se calcula el sumatorio de las entradas y su derivada en la siguiente capa
			for(int k=0; k<pCapas[i+1].nNumNeuronas; k++)
			{
				C += pCapas[i+1].pNeuronas[k].w[j+1] * pCapas[i+1].pNeuronas[k].dX;
			}

			pCapas[i].pNeuronas[j].dX = C * pCapas[i].pNeuronas[j].x * (1-pCapas[i].pNeuronas[j].x);
		}
	}
	
}

// ------------------------------
// Acumular los cambios producidos por un patrón en deltaW
void PerceptronMulticapa::acumularCambio() {
	for(int i=1; i<nNumCapas; i++)
	{
		for(int j=0; j<pCapas[i].nNumNeuronas; j++)
		{
			for(int k=1; k<pCapas[i-1].nNumNeuronas+1; k++)
			{
				pCapas[i].pNeuronas[j].deltaW[k] +=  pCapas[i].pNeuronas[j].dX * pCapas[i-1].pNeuronas[k-1].x;
			}
			pCapas[i].pNeuronas[j].deltaW[0] += pCapas[i].pNeuronas[j].dX;
				

		}
	}


}

// ------------------------------
// Actualizar los pesos de la red, desde la primera capa hasta la última
void PerceptronMulticapa::ajustarPesos() {
	double _deltaW,_ultimoDeltaW;
	float eta = 0.0;
	for(int i=1; i<nNumCapas; i++)
	{
		
		for(int j=0; j<pCapas[i].nNumNeuronas; j++)
		{
			eta=this->dEta*pow(this->dDecremento, -(this->nNumCapas-1-i));
			for(int k=0; k<pCapas[i-1].nNumNeuronas+1; k++)
			{
				_deltaW = pCapas[i].pNeuronas[j].deltaW[k];

				_ultimoDeltaW = pCapas[i].pNeuronas[j].ultimoDeltaW[k];
				

				pCapas[i].pNeuronas[j].w[k] -= eta * _deltaW + dMu * eta * _ultimoDeltaW;



				pCapas[i].pNeuronas[j].ultimoDeltaW[k] = pCapas[i].pNeuronas[j].deltaW[k];

			}
			

		}
	}
}

// ------------------------------
// Imprimir la red, es decir, todas las matrices de pesos
void PerceptronMulticapa::imprimirRed() {

	//Se omite la capa 0, ya que es la de entrada.
	for (int i = 1; i < nNumCapas; i++)
	{
		cout<<"------Capa("<<i<<")------\n";
		for (int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
			//pCapas[i-1].nNumNeuronas, porque en la capa 1, tendra un vector de pesos de tantas entradas en la capa 0
			for (int k = 0; k < pCapas[i-1].nNumNeuronas; k++)
			{
				cout<<"["<<pCapas[i].pNeuronas[j].w[k]<<"] ";
			}
			cout<<"\n";

		}
		
	}


}

// ------------------------------
// Simular la red: propagar las entradas hacia delante, retropropagar el error y ajustar los pesos
// entrada es el vector de entradas del patrón y objetivo es el vector de salidas deseadas del patrón
void PerceptronMulticapa::simularRedOnline(double* entrada, double* objetivo) {

	//Entradas son el Train->Entradas , Objetivo es el Train->Salidas, del dataset leido por fichero
	//Se omite la capa 0, ya que es la de entrada.
	
	for (int i = 1; i < nNumCapas; i++)
	{
	
		for (int j = 0; j < pCapas[i].nNumNeuronas; j++)
		{
			//pCapas[i-1].nNumNeuronas, porque en la capa 1, tendra un vector de pesos de tantas entradas en la capa 0
			for (int k = 0; k < pCapas[i-1].nNumNeuronas+1; k++)
			{
				pCapas[i].pNeuronas[j].deltaW[k] = 0.0;

			}
		

		}
		
	}

	alimentarEntradas(entrada);
	propagarEntradas();
	retropropagarError(objetivo);
	acumularCambio();
	ajustarPesos();

}

// ------------------------------
// Leer una matriz de datos a partir de un nombre de fichero y devolverla
Datos* PerceptronMulticapa::leerDatos(const char *archivo) {
	Datos *data = new Datos();
		std::ifstream leer;
		leer.open(archivo);

	leer >> data->nNumEntradas;

	leer >> data->nNumSalidas;
	
	leer >> data->nNumPatrones;
	std::cout<<"  -->Entradas:" << data->nNumEntradas<< std::endl;
	std::cout<<"  -->Salidas:" << data->nNumSalidas<< std::endl;
	std::cout<<"  -->Patrones:" << data->nNumPatrones<< std::endl;
	data->entradas = (double **)malloc (data->nNumPatrones*sizeof(double *));

	for (int i=0;i<data->nNumPatrones;i++)//Entradas
		data->entradas[i] = (double *) malloc (data->nNumEntradas*sizeof(double));

	data->salidas = (double **)malloc (data->nNumPatrones*sizeof(double *));

	for (int i=0;i<data->nNumPatrones;i++)//Salidas
		data->salidas[i] = (double *) malloc (data->nNumSalidas*sizeof(double));
	//Rellenamos matriz de entrada y salida de datos.
   int i = 0;
   int j = 0;
   
   //int linea=0;
   while (!leer.eof())
   {
     //std::cout<<"Linea("<<linea<<"): -- [ ";
	 for(int x = 0; x < data->nNumEntradas; x++)
	 {
		 leer >> data->entradas[i][x];
		 //std::cout<<"("<<data->entradas[i][x]<<") ";
	 }
	//std::cout<<"] <---> [";
	 for(int y = 0; y < data->nNumSalidas; y++)
	 {
		 leer >> data->salidas[j][y];
		 //std::cout<<"("<<data->salidas[j][y]<<") ";
		 
	 }
	 //std::cout<<"]\n";
      
      i++;
	  j++;
	  //linea++;
   }
   leer.close(); 



	return data;
}

// ------------------------------
// Entrenar la red on-line para un determinado fichero de datos
void PerceptronMulticapa::entrenarOnline(Datos* pDatosTrain) {
	int i;
	for(i=0; i<pDatosTrain->nNumPatrones; i++){
		simularRedOnline(pDatosTrain->entradas[i], pDatosTrain->salidas[i]);
	}
}

// ------------------------------
// Probar la red con un conjunto de datos y devolver el error MSE cometido
double PerceptronMulticapa::test(Datos* pDatosTest) {

	double ERROR = 0.0;

	for(int i=0; i<pDatosTest->nNumPatrones; i++)
	{
		// Cargamos las entradas y propagamos el valor
		alimentarEntradas(pDatosTest->entradas[i]);
		propagarEntradas();
		ERROR += calcularErrorSalida(pDatosTest->salidas[i]);

	}

	ERROR /= pDatosTest->nNumPatrones;
	return ERROR;
}

// OPCIONAL - KAGGLE
// Imprime las salidas predichas para un conjunto de datos.
// Utiliza el formato de Kaggle: dos columnas (Id y Predicted)
void PerceptronMulticapa::predecir(Datos* pDatosTest)
{
	int i;
	int j;
	int numSalidas = pCapas[nNumCapas-1].nNumNeuronas;
	double * salidas = new double[numSalidas];
	
	cout << "Id,Predicted" << endl;
	
	for (i=0; i<pDatosTest->nNumPatrones; i++){

		alimentarEntradas(pDatosTest->entradas[i]);
		propagarEntradas();
		recogerSalidas(salidas);
		
		cout << i;

		for (j = 0; j < numSalidas; j++)
			cout << "," << salidas[j];
		cout << endl;

	}
}

// ------------------------------
// Ejecutar el algoritmo de entrenamiento durante un número de iteraciones, utilizando pDatosTrain
// Una vez terminado, probar como funciona la red en pDatosTest
// Tanto el error MSE de entrenamiento como el error MSE de test debe calcularse y almacenarse en errorTrain y errorTest
void PerceptronMulticapa::ejecutarAlgoritmoOnline(Datos * pDatosTrain, Datos * pDatosTest, int maxiter, double *errorTrain, double *errorTest)
{
	int countTrain = 0;
	Datos * validationData;
	// Inicialización de pesos
	pesosAleatorios();

	double minTrainError = 0;
	double minValError = 0;
	int numSinMejorar;
	int numSinMejorarValidation;
	double testError = 0;
	double testValidation = 0;

	double validationError=0.0;

	// Generar datos de validación
	if(dValidacion > 0 && dValidacion < 1){
		int nNumVal = dValidacion * pDatosTrain->nNumPatrones;
		int * vector = vectorAleatoriosEnterosSinRepeticion(0,pDatosTrain->nNumPatrones-1,nNumVal);
		validationData = new Datos();
		validationData->nNumEntradas = pDatosTrain->nNumEntradas;
		validationData->nNumSalidas = pDatosTrain->nNumSalidas;
		validationData->nNumPatrones = nNumVal;
		
		validationData->entradas = (double **)calloc (validationData->nNumPatrones,sizeof(double *));

		for (int i=0;i<validationData->nNumPatrones;i++)//Entradas
			validationData->entradas[i] = (double *) calloc (validationData->nNumEntradas,sizeof(double));

		validationData->salidas = (double **)calloc (validationData->nNumPatrones,sizeof(double *));
	
		for (int i=0;i<validationData->nNumPatrones;i++)//Salidas
			validationData->salidas[i] = (double *) calloc (validationData->nNumSalidas,sizeof(double));

		
		for(int i = 0; i < nNumVal; i++)
		{
			
			//Entradas
			for(int X = 0; X < validationData->nNumEntradas; X++)
			{
	
			
				validationData->entradas[i][X] = pDatosTrain->entradas[vector[i]][X];
				
			}
			//Salidas
			for(int Y = 0; Y < validationData->nNumSalidas; Y++)
			{
				
				validationData->salidas[i][Y] = pDatosTrain->salidas[vector[i]][Y];
				
			}

		
	
		}
		
		validationError =test(validationData);
	
	}


	// Aprendizaje del algoritmo
	do {

		entrenarOnline(validationData);
		entrenarOnline(pDatosTrain);
		validationError = test(validationData);
		double trainError = test(pDatosTrain);

		if(dValidacion > 0 && dValidacion < 1){
			if( countTrain==0 || validationError < minValError){
				minValError = minValError;
				numSinMejorarValidation = 0;
			}else if( (validationError-minValError) < 0.00001)
			{
				numSinMejorarValidation=0;
			}
			else{
				numSinMejorarValidation=numSinMejorarValidation+1;
			}

			if(numSinMejorarValidation==50){
				cout << "Salida porque no mejora el entrenamiento!!"<< endl;
				break;
			}
		}




		if(countTrain==0 || trainError < minTrainError){
			minTrainError = trainError;
			copiarPesos();
			numSinMejorar = 0;
		}else if( (trainError-minTrainError) < 0.00001)
			numSinMejorar=0;
		else
			numSinMejorar++;

		if(numSinMejorar==50){
			cout << "Salida porque no mejora el entrenamiento!!"<< endl;
			restaurarPesos();
			countTrain = maxiter;
		}

		countTrain++;

		// Comprobar condiciones de parada de validación y forzar
		// OJO: en este caso debemos guardar el error de validación anterior, no el mínimo
		// Por lo demás, la forma en que se debe comprobar la condición de parada es similar
		// a la que se ha aplicado más arriba para el error de entrenamiento
		
		cout << "Iteración " << countTrain << "\t Error de entrenamiento: " << trainError << "\t Error de validación: " << validationError << endl;

	} while (countTrain<maxiter);

	cout << "PESOS DE LA RED" << endl;
	cout << "===============" << endl;
	imprimirRed();

	cout << "Salida Esperada Vs Salida Obtenida (test)" << endl;
	cout << "=========================================" << endl;
	for(int i=0; i<pDatosTest->nNumPatrones; i++){
		double* prediccion = new double[pDatosTest->nNumSalidas];

		// Cargamos las entradas y propagamos el valor
		alimentarEntradas(pDatosTest->entradas[i]);
		propagarEntradas();
		recogerSalidas(prediccion);
		for(int j=0; j<pDatosTest->nNumSalidas; j++)
			cout << pDatosTest->salidas[i][j] << " -- " << prediccion[j] << " ";
		cout << endl;
		delete[] prediccion;

	}

	testError = test(pDatosTest);
	*errorTest=testError;
	*errorTrain=minTrainError;

}

// OPCIONAL - KAGGLE
//Guardar los pesos del modelo en un fichero de texto.
bool PerceptronMulticapa::guardarPesos(const char * archivo)
{
	// Objeto de escritura de fichero
	ofstream f(archivo);

	if(!f.is_open())
		return false;

	// Escribir el numero de capas y el numero de neuronas en cada capa en la primera linea.
	f << nNumCapas;

	for(int i = 0; i < nNumCapas; i++)
		f << " " << pCapas[i].nNumNeuronas;
	f << endl;

	// Escribir los pesos de cada capa
	for(int i = 1; i < nNumCapas; i++)
		for(int j = 0; j < pCapas[i].nNumNeuronas; j++)
			for(int k = 0; k < pCapas[i-1].nNumNeuronas + 1; k++)
				f << pCapas[i].pNeuronas[j].w[k] << " ";

	f.close();

	return true;

}

// OPCIONAL - KAGGLE
//Cargar los pesos del modelo desde un fichero de texto.
bool PerceptronMulticapa::cargarPesos(const char * archivo)
{
	// Objeto de lectura de fichero
	ifstream f(archivo);

	if(!f.is_open())
		return false;

	// Número de capas y de neuronas por capa.
	int nl;
	int *npl;

	// Leer número de capas.
	f >> nl;

	npl = new int[nl];

	// Leer número de neuronas en cada capa.
	for(int i = 0; i < nl; i++)
		f >> npl[i];

	// Inicializar vectores y demás valores.
	inicializar(nl, npl);

	// Leer pesos.
	for(int i = 1; i < nNumCapas; i++)
		for(int j = 0; j < pCapas[i].nNumNeuronas; j++)
			for(int k = 0; k < pCapas[i-1].nNumNeuronas + 1; k++)
				f >> pCapas[i].pNeuronas[j].w[k];

	f.close();
	delete[] npl;

	return true;
}