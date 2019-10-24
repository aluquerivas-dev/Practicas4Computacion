%Función para descifrar un texto cifrado conociendo la mochila supercreciente que se ha utilizado como clave.
%
%   Entradas:
%       s: mochila que debe ser supercreciente.
%       cifrado: vector de cifrado.
%       Salida: El texto claro.
function texto=des_mochila(s,cifrado)

    if mochila(s) == 1
        disp('la mochila es supercreciente')
        
        BITS = [];
        for i=1:size(cifrado,2)
           TEMP = sol_mochila(s, cifrado(i));
           BITS = [BITS, TEMP];
        end
        %En este punto tenemos el vector entero con toda la secuencia de BITS.
        
        %Sacamos cuantos elementos hay que quitar para que sea divisible
        %entre 8 para las cadenas de bits
        if mod(length(BITS), 8) ~= 0
            %Cogemos y guardamos en BITS desde la posicion 1 hasta la
            %longitud de BITS quitandole los elementos que sobran
            BITS = BITS(1:(length(BITS) - mod(length(BITS), 8)));
        end
       
        %Reasignamos en bloques de 8 BITS
        BITS = reshape(BITS, 8,[])';
        %Convertimos a decimal
        DECIMAL = bin2dec(num2str(BITS));
        %Convertimos el decimal en cadena
        texto = [char(DECIMAL)]';
        
    else
        disp('la mochila no es supercreciente')
        disp('no podemos asegurar la unicidad del descifrado, por lo tanto no lo hacemos')
        texto = [];
    end


end

