% Función para hallar la matriz clave en el cifrado Hill conociendo parte del texto claro, del
% criptograma y el orden de la matriz, mediante un ataque de tipo Gauss-Jordan.
% 
%     Entradas:
%     
%         claro: un fragmento de texto llano, de longitud al menos d 2 .
%         
%         cripto: el criptograma, o parte de él, de longitud al menos d 2 .
%         
%         d: el orden que estamos suponiendo para la matriz clave del cifrado Hill.
        
function matrizclave = cripto_hill(textoclaro, textocifrado, orden)

%Debemos de ecomprobar si hace falta meter mas letras a la cadena
%Primero pasamos a numero
    textoclaro=lower(textoclaro);
    textoclaro = letranumero(textoclaro);

      
%Añadimos letras al final hasta completar la longitud
    if(mod(length(textoclaro), orden)~= 0)
        for i=1:(orden-mod(length(textoclaro), orden))
            textoclaro = [textoclaro,23];
        end
    end
Y = reshape(letranumero(textocifrado), orden, [])';
X = reshape(textoclaro, orden, [])';

for i=1:orden
    AUXILIAR = X(i,i);
    
    [G, U, V] = gcd(27, AUXILIAR);
    
    %Si existe el inverso agregamos zeros.
    %Si no existe inverso se trata de buscar el intercambio de filas.
    if G ~= 1
        %No exise inverso se encuentra el numero de la primera fila inferior con 
        %la que poder intercambiarlo
        for j=i+1:size(X,1)
            [G, U, V] = gcd(27, X(j, i));
            if G == 1
            %Cambios en matrix X
                fila = X(i, :);
                X(i, :) = X(j, :);
                X(j, :) = fila;
            %Cambios en matrix Y
                fila = Y(i, :);
                Y(i, :) = Y(j, :);
                Y(j, :) = fila;
            end
        end
    end
     %Si existe el inverso agregamos zeros.
        X(i, :) = mod(X(i,:)*V, 27);
        Y(i, :) = mod(Y(i,:)*V, 27);
     %Se agregan zeros
        for j=1:size(X,1)
            if j~=i
                aux2 = X(j,i);
                X(j, :) = mod(X(j,:)-aux2*X(i,:),27);
                Y(j, :) = mod(Y(j,:)-aux2*Y(i,:),27);
            end
            
        end
    
end
% La matriz clave sera formada por la matriz Y
matrizclave = Y(1:orden,1:orden)';
