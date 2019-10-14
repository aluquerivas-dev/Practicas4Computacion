function texto=descifro_permutacion(p,texto)
    texto=lower(texto);
    texto = letranumero(texto);
    if mod(size(texto,2),size(p,2)) == 0
        M = inv_modulo(matper(p),27)
        X = reshape(texto, size(M, 2), [])
        Y = M * X
        texto = reshape(Y,1,[]);
        texto = numeroletra(texto);
    else
        disp('El texto no tiene la longitud adecuada')
    end
end

