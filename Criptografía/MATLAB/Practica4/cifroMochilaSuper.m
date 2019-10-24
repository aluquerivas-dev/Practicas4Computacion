
function cifrado=cifroMochilaSuper(s,texto)

    if mochila(s) == 1
            %Casteamos a double el texto para convertirlo en su valor decimal ascii
            ascii = double(texto);
            %Con dec2bin convertimos ese texto ascii en binarios de 8 elementos.
            bin = dec2bin(ascii,8);
            bin = reshape(bin', 1, []);

            if((mod(size(bin,2), length(s)) ~= 0))
                %Si no es posible de dividir se añaden 1 al final de la
                for i=1:length(s)-mod(size(bin,2), length(s))
                   bin = [bin, '1'];
                end
            end

            %Volvemos a aplicar el reshape
            bin = reshape(bin,length(s), [])';

            %Y ahora lo ciframos
            cifrado = [];
            aux = 0;
            for i=1:size(bin,1)
                for j=1:size(bin,2)
                   if(bin(i,j) == '1')
                        aux = aux + s(j);
                   end
                end
                cifrado = [cifrado, aux];
                aux = 0;
            end
    else
        disp('la mochila no es supercreciente')
        cifrado = [];
    end

end

