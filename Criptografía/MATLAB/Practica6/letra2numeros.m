% A cada letra del texto, la función le debe asociar su correspondiente valor de Z 27 , con dos
% dígitos: a:00, b:01, ..., z:26.
% Entradas: texto: el texto llano
% Salida: doble: cadena numérica formada por los números asociados a cada letra del
% texto.
function doble =letra2numeros(texto)
  ARRAY = [];

    for i=1:length(texto)
        number = num2str(letranumero(texto(i)));
        if length(number) == 1
           aux = strcat('0',number);
        else
           aux = number;
        end
        ARRAY = [ARRAY, aux];
        
        doble = ARRAY;
end

