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

        
    aux = zeros(1,size(s,2));
    for i = size(s,2) : -1 : 1
        if s(i) <= obj
            aux(i) = 1;
            obj = obj - s(i);
        end
    end
   if obj == 0
       if mochila(s)==1
           disp('la mochila es supercreciente')
       else
           
           X = s;
            Y = sort(s);
            if sum(X==Y) ~= size(s,2) && mochila(s) == 0
            disp('la mochila no es supercreciente, sus elementos no estan ordenados en orden creciente')
            end
           
       end
       v = aux;
   else%%No se encuentra el objetivo
       if mochila(s) == 1
           disp('el objetivo no se alcanza, la mochila si es supercreciente')
       else
            disp('con el algoritmo usado no encuentro el objetivo (la mochila no es supercreciente)')    
       end
       
       v = 0;
   end
    
end

