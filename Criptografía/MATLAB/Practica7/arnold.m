% Funci�n que va a ordenar o a desordenar una foto. Para elegir una de estas
% dos opciones se debe usar un switch con dos casos: caso 1 para desordenar
% y caso 2 para ordenar.
% Entradas:
% foto: fotograf�a (que debe ser cuadrada), a la que queremos aplicarle
% una transformaci�n de Arnold.
% Debe ser la fotograf�a original en el caso 1, y la fotograf�a
% desordenada seg�n la matriz A en el caso 2.
% A: matriz que se va a usar para desordenar en el caso 1, o que ya se
% ha usado para desordenar en el caso 2. Debe ser una matriz 2x2 con
% inversa m�dulo el n�mero de filas de foto.
% Salida:
% En el caso 1 la imagen desordenada seg�n la transformaci�n indicada
% por la matriz A.
% En el caso 2 la matriz ordenada teniendo en cuenta que se desorden�
% usando la matriz A.
function arnold(foto, A)
    valor = input('Introduce 1:Desordenar , 2:Ordenar --> ')
    
    switch valor
        case 1
            imagen =  desorden_pixel(foto,A);
            imshow(imagen);
            imwrite(imagen, './imagenes_practica7/imagenDesordenada.bmp');
    
        case 2
            IMG_matriz = imread(foto);
            [FILAS,COLUMNAS,CANALES] = size(IMG_matriz);
            invA = inv_modulo(A,FILAS);
            imagen = desorden_pixel(foto,invA);
            imshow(imagen);
            imwrite(imagen, './imagenes_practica7/imagenOrdenada.bmp');
    end
    

end

