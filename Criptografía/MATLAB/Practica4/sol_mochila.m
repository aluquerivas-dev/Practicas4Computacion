%Función para comprobar si una mochila dada cumple un determinado objetivo con el
%algoritmo estudiado para mochilas supercrecientes. Es una segunda función de control para
%poder implementar el cifrado de tipo mochila.
%
%   Entradas:
%       s: mochila. La función debe comprobar si es realmente una mochila.
%       obj: objetivo a alcanzar. La función debe comprobar si la entrada cumple los requisitos
%            para poder ser un objetivo.
%
%   Salida: En caso de que el objetivo se cumpla, un vector v indicando los valores de la
%           mochila que permiten obtenerlo. En caso contrario v=0 y un mensaje. Obsérvese que
%           el objetivo pudiera alcanzarse aún cuando la mochila no fuera supercreciente. Por
%           tanto, también debe indicar si la mochila es supercreciente o no.
function v=sol_mochila (s,obj)

    X = s;
    Y = sort(s);
    if sum(X==Y) ~= size(s,2)
        disp('la mochila no es supercreciente, sus elementos no estan ordenados en orden creciente')
    end
      
   
end

