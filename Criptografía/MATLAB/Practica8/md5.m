%  md5
%  Halla el resumen MD5 del mensaje, como una cadena hexadecimal.
function fhash = md5(mensaje)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%x%%%

%% PASO 1 INTRODUCIMOS VARIABLES Y CONSTANTES NECESARIAS
clc
%PASO1.1 MENSAJE COMO PARAMETRO
%PASO 1.2.- VAMOS A TRABAJAR MODULO M=2^32
m=2^32;
% PASO 1.3.- CREAMOS UNA MATRIZ S PARA HACER LA ROTACI�N,
% LOS N�MEROS NEGATIVOS POR SER UNA ROTACI�N A IZQUIERDA
s = [-7, -12, -17, -22;-5,  -9, -14, -20;-4, -11, -16, -23;-6, -10, -15, -21];

% PASO 1.4.- t ES LA TABLA QUE USAREMOS M�S ADELANTE,para construir la funci�n
% Hash  del emnsaje
t = fix(abs(sin(1:64)) .* m);

% PASO 1.5.- INICIALIZAMOS LA HASH
% MD5 utiliza las cuatro palabras siguientes:
% A=01 23 45 67 pero en Little endian:67 45 23 01
% B=89 ab cd ef --> ef cd ab 89 
% C=fe dc ba 98 --> 98 ba dc fe
% D=76 54 32 10 --> 10 32 54 76

fhash = [hex2dec('67452301'), hex2dec('efcdab89'), hex2dec('98badcfe'), hex2dec('10325476')];
fhash =uint32(fhash);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PASO 2.- PREPARAMOS EL MENSAJE PARA APLICARLE LA HASH
bitlen = length(mensaje)*8;
mensaje = abs(mensaje);
bytelen = numel(mensaje); %numero de elementos del vector 

% PASO 2.1.-
% A?ADIMOS AL MENSAJE UN 1 Y  LOS 0'S NECESARIOS PARA QUE EL N?NERO DE BITS
% SEA CONGRUENTE CON 448 M?DULO 512
% COMO TENEMOS BYTES, A?ADIMOS 128 (10000000) Y LOS CEROS NECESARIOS PARA QUE 
% EL N?MERO DE BYTES SEA CONGRUENTE CON 56 M?DULO 64

mensaje = [mensaje, 128];

while 1
   bytlen = numel(mensaje);
   if mod(bytlen, 64) == 56
      break 
   else
      mensaje = [mensaje, 0];
   end
end

%mensaje = [mensaje, 128, zeros(1, mod(55-bytlen,64))]
% PASO 2.2.-
% C?MO CADA PALABRA EST? FORMADA POR 4 BYTES, HACEMOS UNA MATRIZ DE 4 FILAS
% CON LOS BYTES DEL MENSAJE, AS? CADA COLUMNA SER? UNA PALABRA 

matrizMensj = reshape(mensaje, 4, []);

% PASO 2.3.-
% CONVERTIMOS CADA COLUMNA A ENTEROS DE 32 BITS, little endian.
AUX = [];
for i=1:size(matrizMensj, 2)
    aux = matrizMensj(1,i) + 2^8*matrizMensj(2,i) + 2^16*matrizMensj(3,i) + 2^24*matrizMensj(4,i);
    AUX = [AUX, uint32(aux)];
end

% PASO 2.4.-

% A?ADIMOS LA LONG DEL MENSAJE ORIGINAL COMO UN ENTERO 
% DE 64 BITS __>8 bytes__>dos palabras : little endian.
%Ya tenemos bitlen del principio del mensaje
AUX = [AUX, mod(bitlen,m), mod(floor(bitlen/m), m)];

mensaje = double(AUX);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PASO 3. REALIZAMOS LA FUNCI�N HASH
% CADA BLOQUE DE  512bit
% TENEMOS ENTEROS DE 32 BITS (PALABRA)CADA BLOQUE TIENE 16 ELEMENTOS
% (PALABRAS)
% message(k + (0:15))

for k = 1:16:numel(mensaje)
    a = fhash(1); b = fhash(2); c = fhash(3); d = fhash(4);
    for i =1:64
        % Convertimos b, c, d a vector fila  of bits (0s and 1s).
        bv = dec2bin(b, 32) - '0';
        cv = dec2bin(c, 32) - '0';
        dv = dec2bin(d, 32) - '0';
        % obtenemos  f  = mix of b, c, d.
        %      ki = indice  0:15, del mensaje (k + ki).
        %      sr = filas 1:4, de  s(sr, :).
        if i <= 16          % Turno 1
            f = (bv & cv) | (~bv & dv);
            ki = i - 1;
            sr = 1;
        elseif i <= 32      % Turno 2
            f = (bv & dv) | (cv & ~dv);
            ki = mod(5 * i - 4, 16); 
            sr = 2;
        elseif i <= 48      % ronda 3
            f = xor(bv, xor(cv, dv));
            ki = mod(3 * i + 2, 16);   
            sr = 3;
        else                % Turno 4
            f = xor(cv, bv | ~dv);
            ki = mod(7 * i - 7, 16);
            sr = 4;
        end
        % Convert f, DE VECTOR FILA DE BITS  A  ENTEROS DE 32-bit .
        f = uint32(bin2dec(char(f+'0')));
       
       
        % HACEMOS LA ROTACIONES
        sc = mod(i - 1, 4) + 1;
        sum = mod(a + f + mensaje(k + ki) + t(i), m);
        sum = dec2bin(sum, 32);
        sum = circshift(sum, [0, s(sr, sc)]);
        sum = bin2dec(sum);
        % ACTUALIZAMOS  a, b, c, d.
        %tenemos que mover uno a la derecha
        aux = d;
        d = c;
        c = b;
        b = mod(sum+b,m);
        a = aux;
    end
    
    % MODIFICAMOS EL HASH.
    fhash = mod(fhash + [a,b,c,d], m);
    
    
end

% CONVERTIMOS HASH DE ENTEROS DE 32 BITS  , LITTLE ENDIAN, A BYTES .


% CONVERTIMOS HASH A HEXADECIMAL.
