% Funci�n descifro_num =descifro_rsa_num (d, n, cifrado_numero)
% Funci�n que aplica la funci�n de descifrado del m�todo RSA a un vector num�rico (que supuestamente se habr� cifrado previamente con la clave p�blica), utilizando la clave privada proporcionada.
% Entradas:
% (d, n): clave privada.
% cifrado_numero: vector num�rico, se supone que cifrados seg�n la clave p�blica con RSA.
% Salida: descifro_num: vector num�rico obtenidos tras aplicar la funci�n de descifrado con RSA.
function descifro_num =descifro_rsa_num (d, n, cifrado_numero)
AUX = []
%Aplicar la potencia con la clave privada.
    for i=1:length(cifrado_numero)
       AUX = [AUX, potencia(cifrado_numero(i), d, n)]; 
    end
    descifro_num = AUX
end

