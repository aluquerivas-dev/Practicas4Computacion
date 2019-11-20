% Función de descifrado según el método RSA, que siga todos los pasos estudiados.
function descifrado = descifro_rsa (d, n, cifrado_numero)

    descifro_numeros = descifro_rsa_num(d, n, cifrado_numero);
    descifrado = num_descifra(n, descifro_numeros);
    
end

