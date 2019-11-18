% El programa debe pedir al usuario los valores de los primos p y q. Una sugerencia, para facilitar
% la introducción de estos valores, es pedirle al programa que muestre en primer lugar un listado
% de números primos hasta un cierto valor.
% 4
% Si los números anteriores son lo suficientemente grandes puede considerar e = 1 + 2 2 =
% 65537, y si no o bien solicitarlo al usuario o generar cualquier valor para e válido de la manera
% que consideréis más oportuna.
function genero_clave()
    num = input('Introduzca hasta que primo quieres generar: ')
    primes(num)
    p = input('Introduzca el valor del primo p:')
    q = input('Introduzca el valor del primo q:')
    
    fi_of_n = (p-1)*(q-1);
    n = p*q;
    e = 0;
    %%%%Inicio búsqueda  número e 
    if fi_of_n > 65537
        e = 65537;
    else
        %Buscar el primer e que sea primo relativo con n = q*p
        for indice = 2:fi_of_n-2
            if gcd(indice,fi_of_n) == 1
                e = indice;
                break;
            end
        end
    end
    %%%%Busqueda número e acabada
    [g, c, d] = gcd(e, fi_of_n);
    d = mod(c, fi_of_n);
    fprintf('La clave privada es (%d,%d): \n',n,d)
    fprintf('La clave publica es (%d,%d) : \n',n,e)
end

