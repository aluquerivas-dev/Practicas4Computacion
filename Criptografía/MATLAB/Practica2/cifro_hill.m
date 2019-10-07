function cifrado = cifro_hill(A,m,texto)
    texto=lower(texto);
    texto = letranumero(texto);
    if isequal(inv_modulo(A,m),inv_modulo(A,m))
        TAM = size(A);
        TAM = TAM(1);
        TAM_SHAPE = size(texto)/TAM;
        TAM_SHAPE = TAM_SHAPE(2);

        texto = reshape(texto,TAM,TAM_SHAPE);

        for i=1:TAM_SHAPE
            array(:,i)=mod(A*texto(:,i),m);     
        end
        cifrado = reshape(array,1,[]);
        
        cifrado = numeroletra(cifrado);
        
        cifrado
        
        
    end 
end

