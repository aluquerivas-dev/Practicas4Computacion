% Función que debe hacer los siguientes pasos: pasar texto a una cadena numérica usando 2
% dígitos por letra, calcular el tamaño de los bloques a partir de n, aplicar la función anterior para
% obtener los bloques de números, y cifrarlos según el sistema RSA usando la clave pública (n,e).
% Entradas:
% e y n: clave pública para el cifrado RSA.
% texto: texto que queremos cifrar.
% Salida: cifrado: vector formado por los bloques ya cifrados.

function desci = cifro_rsa(e,n, texto)

    texto = letra2numeros(texto);
    tam = numel(num2str(abs(n)));
    
    preparado = prepa_num_cifrar(tam-1,texto);
    
    CIFRADO = [];
    for i=1:length(preparado)
        CIFRADO = [CIFRADO, potencia(preparado(i), e, n)];
    end
    desci = CIFRADO;
end

