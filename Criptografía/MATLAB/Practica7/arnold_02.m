% Función que debe desordenar los píxeles de la imagen foto según la matriz
% A, de manera sucesiva. Vamos a usar un switch con dos casos: caso 1 para
% desordenar hasta recuperar la imagen original y caso 2 para desordenar el
% número de veces que se indique.
% Entradas:
% foto: foto que queremos desordenar.
% A: matriz que determina la transformación.
% Salida: potencia: el número de veces que hemos realizado la
% transformación de forma sucesiva. Además, en ambos casos debe
% mostrar la imagen original y todas las imagenes transformadas que
% se hayan ido realizando.
function potencia = arnold_02(foto, A)
IMG_matriz = imread(foto);
[FILAS,COLUMNAS,CANALES] = size(IMG_matriz);
valor = input('introduce 1 si quieres desordenar la imagen hasta volver a la original, o 2 si quieres desordenarla hasta una determinada potencia: 1 --> ');
AUX = 0;  
    switch valor
        case 1
            potencia = pote(A,FILAS);
            for i=1:potencia
                AUX = desorden_pixel(foto,A);
                CADENA = strcat('potencia',num2str(i));
                CADENA = strcat(CADENA,'.bmp');
                CADENA = strcat('./TEMP/',CADENA);
                imwrite(AUX,CADENA);
                foto = CADENA
                CADENA = 0;
                
            end
        case 2
            aux_pote = input('¿Cuántas transformaciones quieres hacer? --> ');
            potencia = pote(A,FILAS) + 1;
            aux_pote = mod(aux_pote,potencia)
            CADENA = strcat('potencia',num2str(1));
            CADENA = strcat(CADENA,'.bmp');
            CADENA = strcat('./TEMP/',CADENA)
            imwrite(IMG_matriz,CADENA);
            CADENA = 0
            for i=2:aux_pote
                AUX = desorden_pixel(foto,A);
                CADENA = strcat('potencia',num2str(i));
                CADENA = strcat(CADENA,'.bmp');
                CADENA = strcat('./TEMP/',CADENA);
                imwrite(AUX,CADENA);
                foto = CADENA
                CADENA = 0;
                
            end
            
            
    end
end

