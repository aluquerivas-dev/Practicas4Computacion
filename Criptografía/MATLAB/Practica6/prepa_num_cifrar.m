% Función que convierte una cadena numérica en bloques de un tamaño dado, después
% convierte dichos bloques en números y los almacena en un vector. Si es necesario para
% completar el último bloque deberemos añadir varios 30’s y/o un 0.
% Entradas:
% tama: tamaño de los bloques.
% bloque: cadena numérica.
% Salida: blo: vector formado por los números que se corresponden con cada uno de los
% bloques.
function blo = prepa_num_cifrar(tama, bloque)
    cadena = bloque;
    if mod(length(bloque),tama) ~= 0 %Sicnifica que hay que agregar 30 o 0
        until_filled = tama-mod(length(bloque),tama);
        while until_filled ~= 0
            if until_filled >= 2
                cadena = strcat(cadena,'30');
                until_filled = until_filled - 2;
            else
                cadena = strcat(cadena,'0');
                until_filled = until_filled - 1;
            end
            
        end
    end
    
    re = reshape(cadena,tama,[])';
    ARRAY = [];
    for i=1:size(re,1)
        ARRAY = [ARRAY,str2num(re(i,:))];
    end
   
    blo = ARRAY;
end
