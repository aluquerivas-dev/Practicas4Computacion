% Construir una función para cifrar un mensaje por el método Afín.
% 
%     Entradas: 
%     
%         clave:Es al clave multiplicativa, el programa debe comprobar 
%               que es un número entero y con mcd(clave , 27)=1.

%         d:el desplazamiento, también tiene que ser un número entero.

%         texto:texto claro que queremos encriptar, una vez introducido (entre ‘ ‘), 
%               el programa debe  eliminar  todo  lo  que  no  sea  de  nuestro  
%               abecedario,  para  ello  debe  llamar  a  la función  letranumero(texto).
% 
%      Salida:   El criptograma.

function cifradoafin = afin(clave,d,texto)
    
    if mod(clave,1) ~= 0 || mod(d,1) ~= 0 || d<0 || clave<0
        error('No se cumplen las condiciones')
        
        return
    end

    if gcd(clave,27) == 1
        disp('Se cumplen las condiciones')
        cifradoafin = letranumero(texto);
        cifradoafin = cifradoafin * clave + d;
        cifradoafin = mod(cifradoafin,27);
        cifradoafin = numeroletra(cifradoafin);
        disp(['El criptograma: ',cifradoafin])        
    else
        error('No se cumplen las condiciones')
    end
end

