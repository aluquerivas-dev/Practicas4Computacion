function cifrado = cifro_hill(A,m,texto)
    texto=lower(texto);
    texto = letranumero(texto);
    if ~isequal(inv_modulo(A,m),0)

        if mod(size(texto,2),size(A,1))~=0
            RESTO = mod(size(texto,2), size(A,1))
               for i=1:size(A,1)-RESTO
               texto=[texto,23];
            end
        end
        
        
        TAM_SHAPE = (size(texto)/size(A,1));
        TAM_SHAPE = TAM_SHAPE(2);
   
        texto = reshape(texto,size(A,1),TAM_SHAPE);

        for i=1:TAM_SHAPE
            array(:,i)=mod(A*texto(:,i),m);     
        end
        cifrado = reshape(array,1,[]);
        
        cifrado = numeroletra(cifrado);
    else
        cifrado = 0;
    end
    
        
end

