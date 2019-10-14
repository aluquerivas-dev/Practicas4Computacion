function cifrado=cifro_permutacion(p,texto)
    texto=lower(texto);
    texto = letranumero(texto); 
    
    if permutacion_v(p) == 1 
        if mod(size(texto,2),size(p,2))~=0
            RESTO = mod(size(texto,2), size(p,1));
               for i=1:size(p,1)-RESTO
               texto=[texto,23];
            end
        end 
        
        
    M = matper(p);
    X = reshape(texto, size(M, 2), []);
    
    Y = M*X;
    
    cifrado = reshape(Y,1,[]);
    cifrado = numeroletra(cifrado);
    end
    
end

