function matrizclave = cripto_hill(textoclaro, textocifrado, orden)

%Pasamos el texto a numero y creamos las matrices para hacer el
%criptoanalisis


%Metemos z al final para poder hacer despues el reshape
aux = mod(length(textoclaro), orden);
    if(aux~= 0)
        for i=1:(orden-aux)
            textoclaro = strcat(textoclaro, 'z');
        end
    end
    
NUMCLARO = letranumero(textoclaro);
NUMCRIFRADO = letranumero(textocifrado);

Y = reshape(NUMCLARO, orden, []);
X = reshape(NUMCRIFRADO, orden, []);

Y = Y';
X = X';

for i=1:orden
    aux = X(i,i);
    [G, U, V] = gcd(27, aux);
    
    %Intente esta parte pero fui apurado y no era capaz de sacarla.
end

matrizclave = 0;

