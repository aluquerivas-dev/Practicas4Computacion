function cifradoafin = cifradoafin(clave,d,texto)
    if gcd(clave,27) == 1 && mod(clave,1) == 0 && clave>=0 && mod(d,1) == 0 && d>=0
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

