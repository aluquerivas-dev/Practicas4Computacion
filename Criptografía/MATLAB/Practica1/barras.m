function comparo = barras(v)
    frecuenciaCastellano = [0.1311 4; 0.106 0; 0.0847 19; 0.0823 15; 0.0716 8; 0.0714 13; 0.0695 18; 0.0587 3; 0.054 20; 0.0485 2; 0.0442 11; 0.0434 21; 0.0311 12; 0.0271 16; 0.014 6; 0.0116 1; 0.0113 5; 0.0082 22; 0.0079 25; 0.0074 17; 0.006 7; 0.0026 26; 0.0025 9; 0.0015 24; 0.0012 23; 0.0011 10; 0.001 14];
    [frecuencia, frecuenciaOrdenada] = cripto_ana_orden(v);
    comparo = [frecuenciaCastellano, frecuenciaOrdenada];
    %subplot(m,n,p) divide la figura actual en una cuadr�cula de m por n y crea ejes en la posici�n especificada por p. MATLAB� numera las posiciones de subgr�fico por fila. El primer subgr�fico es la primera columna de la primera fila, el segundo subgr�fico es la segunda columna de la primera fila, y as� sucesivamente. 
    %Si existen ejes en la posici�n especificada, este comando convierte los ejes en los ejes actuales.
     TAM = size(frecuenciaCastellano);
    subplot(2,1,1);
    % bar(ejeX,ejeY, 'color')
    bar(frecuenciaCastellano(1:TAM(1), 2), frecuenciaCastellano(1:TAM(1),1), 'r');
    subplot(2,1,2);
    bar(frecuenciaOrdenada(1:TAM(1), 2), frecuenciaOrdenada(1:TAM(1),1), 'b');
end

