% Función igual a la anterior, salvo que en vez de recibir un texto, recibe ya los bloques de
% números.
% Entradas:
% e y n: clave pública para el cifrado RSA.
% blo: vector de números.
% Salida: cifrado: vector formado por los bloques introducidos ya cifrados.
function cifrado = cifro_rsa_num(e, n, blo)

    CIFRADO = [];
    for i=1:length(blo)
        CIFRADO = [CIFRADO, potencia(blo(i), e, n)];
    end
    cifrado = CIFRADO;
end

