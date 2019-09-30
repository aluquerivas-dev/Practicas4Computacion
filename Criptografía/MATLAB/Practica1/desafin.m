function descifraafin = desafin(clave, d, texto)
    X = letranumero(texto);
if gcd(clave,27) == 1
   [G, U, V]= gcd(27, clave);
    X =  V * (X - d);
    X = mod(X,27);
 
else
    error('Error')
    
end

descifraafin = numeroletra(X)
