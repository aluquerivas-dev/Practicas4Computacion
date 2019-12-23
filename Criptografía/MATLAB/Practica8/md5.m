%  md5
%  Halla el resumen MD5 del mensaje, como una cadena hexadecimal.
function fhash = md5(mensaje)
m=2^32;

s = [-7, -12, -17, -22;-5,  -9, -14, -20;-4, -11, -16, -23;-6, -10, -15, -21];


t = fix(abs(sin(1:64)) .* m);


fhash = [hex2dec('67452301'), hex2dec('efcdab89'), hex2dec('98badcfe'), hex2dec('10325476')];
fhash =uint32(fhash);

bitlen = length(mensaje)*8;
mensaje = abs(mensaje);
bytelen = numel(mensaje); 

mensaje = [mensaje, 128];

while 1
   bytlen = numel(mensaje);
   if mod(bytlen, 64) == 56
      break 
   else
      mensaje = [mensaje, 0];
   end
end

matrizMensj = reshape(mensaje, 4, []);


AUX = [];
for i=1:size(matrizMensj, 2)
    aux = matrizMensj(1,i) + 2^8*matrizMensj(2,i) + 2^16*matrizMensj(3,i) + 2^24*matrizMensj(4,i);
    AUX = [AUX, uint32(aux)];
end

AUX = [AUX, mod(bitlen,m), mod(floor(bitlen/m), m)];

mensaje = double(AUX);

for k = 1:16:numel(mensaje)
    a = fhash(1); b = fhash(2); c = fhash(3); d = fhash(4);
    for i =1:64
        bv = dec2bin(b, 32) - '0';
        cv = dec2bin(c, 32) - '0';
        dv = dec2bin(d, 32) - '0';

        if i <= 16
            f = (bv & cv) | (~bv & dv);
            ki = i - 1;
            sr = 1;
        elseif i <= 32
            f = (bv & dv) | (cv & ~dv);
            ki = mod(5 * i - 4, 16); 
            sr = 2;
        elseif i <= 48 
            f = xor(bv, xor(cv, dv));
            ki = mod(3 * i + 2, 16);   
            sr = 3;
        else 
            f = xor(cv, bv | ~dv);
            ki = mod(7 * i - 7, 16);
            sr = 4;
        end
        
        f = uint32(bin2dec(char(f+'0')));
       
       
      
        sc = mod(i - 1, 4) + 1;
        sum = mod(a + f + mensaje(k + ki) + t(i), m);
        sum = dec2bin(sum, 32);
        sum = circshift(sum, [0, s(sr, sc)]);
        sum = bin2dec(sum);

        aux = d;
        d = c;
        c = b;
        b = mod(sum+b,m);
        a = aux;
    end
    
 
    fhash = mod(fhash + [a,b,c,d], m);
    
    
end
