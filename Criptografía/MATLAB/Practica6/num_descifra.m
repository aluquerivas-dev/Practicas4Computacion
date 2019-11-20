% Funci�n que transforma un vector num�rico en letras (dos d�gitos por letra). Debe completar los bloques para que tengan longitud d�gitos(n)-1, concatenarlos y agrupar de dos en dos, eliminar los posibles 30�s y/o 0 que pueda haber al final, y pasar a letras.
% Entradas:
% n: n�mero que va a determinar el tama�o de los bloques, d�gitos(n)-1.
% bloque_numero: vector num�rico.
% Salida: desci: cadena alfab�tica con el texto asociado a los bloques de n�meros.
function desci = num_descifra (n, bloque_numero)

tama = length(num2str(n))-1;
BLOQUE = [];
%Pasamos  cada parte del bloque a CADENA y metemos ceros
for i=1:length(bloque_numero)
    AUX = num2str(bloque_numero(i));
    if length(AUX) < tama
        while length(AUX) ~= tama
           AUX = strcat('0', AUX);
         end
    end
    BLOQUE = [BLOQUE, AUX];
end


BLOQUE = reshape(BLOQUE, 2, [])';
%Agrupamos los numeros por filas y los agrupamos
BLOQUE
NUMS =[];
for i=1:length(BLOQUE)
   NUMS = [NUMS, str2num(BLOQUE(i,:))];
end
%Eliminar 30 si existen al final
AUX_NUM = [];
for i=1:length(NUMS)
   if NUMS(i) ~= 30
       AUX_NUM = [AUX_NUM, NUMS(i)];
   end
end
desci = numeroletra(AUX_NUM);
end

