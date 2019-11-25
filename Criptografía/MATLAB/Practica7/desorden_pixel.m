% Función que desordena los píxeles de las matrices asociadas a una imagen,
% foto, de acuerdo a la transformación asociada a la matriz A. No queremos
% que nos muestre nada, ni imágenes ni matrices, sólo que guarde las
% matrices obtenidas para usarlas en otras funciones.
% Para ello se puede usar setappdata (gcf, ' matriz ' , matriz), y cuando más
% adelante necesitemos usar esa matriz, matriz = getappdata (gcf, ' matriz ' ).
% Entradas:
% foto: la foto de la que queremos desordenar sus píxeles. Debe ser
% cuadrada.
% A: matriz que nos determina la transformación. Debe ser 2x2 y tener
% inversa módulo el número de filas de foto.
% Salidas: Ninguna. Debe guardar las nuevas matrices obtenidas para
% un posible uso posterior.
function desorden_pixel(foto,A)

    IMG_matriz = imread(foto);
    [FILAS,COLUMNAS,CANALES] = size(IMG_matriz);
    
    if FILAS < COLUMNAS
        disp('Se resiza la matrix')
        IMG_matriz = IMG_matriz(:,1:FILAS,:);
        [FILAS,COLUMNAS,CANALES] = size(IMG_matriz);
    else
        disp('Se resiza la matrix')
        IMG_matriz = IMG_matriz(1:COLUMNAS,:,:);
        [FILAS,COLUMNAS,CANALES] = size(IMG_matriz);
    end
    
    %Comprobamios que hay sea inversible
     [F,C] = size(A);
     
     [G,U,V] = gcd(round(det(A)),FILAS);
     if F ~= C || F ~= 2 || C ~= 2 || G ~= 1
         disp('Matriz A inválida')
         return
     end
     M_AUX = zeros(FILAS,COLUMNAS,CANALES);
     for filas=1:FILAS
         for columnas=1:COLUMNAS
              ARRAY = mod(A*[filas columnas]',FILAS);
              x = ARRAY(1);
              y = ARRAY(2);
              
              if x == 0
                   x = FILAS;
              end
              if y == 0
                  y = COLUMNAS;
              end
              M_AUX(x,y,:) = IMG_matriz(filas,columnas,:);
              
         end
     end
     M_AUX=uint8(M_AUX);
     imwrite(M_AUX,'prueba.bmp')
end

