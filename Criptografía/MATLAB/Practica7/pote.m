% Función que debe calcular el mínimo valor del exponente de la potencia de
% A que módulo m es igual a la matriz identidad.
% Entradas:
% A: matriz (cuadrada de orden 2 y con inversa módulo m).
% m: módulo de trabajo.
% Salida: El valor del exponente que hace que la correspondiente
% potencia de A sea la identidad.
function n = pote(A,m)
    [FILAS, COLUMNAS] = size(A);
    if FILAS == 2 && COLUMNAS == 2
        IDENTIDAD = eye(2);
        n = 1;
        AUX = A;
        while ~isequal(AUX, IDENTIDAD)
            AUX = mod(AUX*A, m);
            n = n +1;
        end
    else
       disp('La matriz A es inválida.'); 
    end
end

