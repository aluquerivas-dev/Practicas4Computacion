% Función descifro_num =descifro_rsa_num (d, n, cifrado_numero)
% Función que aplica la función de descifrado del método RSA a un vector numérico (que supuestamente se habrá cifrado previamente con la clave pública), utilizando la clave privada proporcionada.
% Entradas:
% (d, n): clave privada.
% cifrado_numero: vector numérico, se supone que cifrados según la clave pública con RSA.
% Salida: descifro_num: vector numérico obtenidos tras aplicar la función de descifrado con RSA.
function descifro_num =descifro_rsa_num (d, n, cifrado_numero)
AUX = []
%Aplicar la potencia con la clave privada.
    for i=1:length(cifrado_numero)
       AUX = [AUX, potencia(cifrado_numero(i), d, n)]; 
    end
    descifro_num = AUX
end

