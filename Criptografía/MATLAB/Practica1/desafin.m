% Función para descifrar un mensaje que ha sido cifrado por el método Afín 
% y conocemos las claves de cifrado (clave y d).
% 
%     Entradas: 
%     
%         clave: el número entero que se ha usado para multiplicar.
%         d: el número entero que se ha usado para trasladar. 
%         texto: texto encriptado, del que queremos obtener el texto claro.
% 
%     Salida:   El mensaje claro.
    
function descifraafin = desafin(clave, d, texto)

    if mod(clave,1) ~= 0 || mod(d,1) ~= 0 || d<0 || clave<0
        error('No se cumplen las condiciones')
        return
    end
    
    X = letranumero(texto);
if gcd(clave,27) == 1
   [G, U, V]= gcd(27, clave);
    X =  V * (X - d);
    X = mod(X,27);
 
else
    error('Error')
    
end

descifraafin = numeroletra(X)
