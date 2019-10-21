% Funcion que comprueba si una mochila supercreciente es valida
% Tenemos en cuenta si tenemos mochilas con numeros reales con 1 o 2
% elementos ,que no metamos numeros negativos, que se cumplan el principio
% de mochila supercreciente.
function valida = mochila(s)

    if isvector(s) == false || ischar(s)
        valida = 0;
        return
    end
    if sum(mod(s,1))~=0 && sum(s)>0
        disp('algun valor de la mochila no es entero positivo')
        valida = 0;
        return
    end
    %Comprobar casos de mochilas de 1 o 2 elementos
       %1Elementos
       if size(s,2) == 1
           valida = 1;
           return
       end
       %2 Elementos
     if size(s,2) < 3
         if s(1)>s(2)
             valida = 0;
             return
         else
             valida = 1;
             return
         end
         
     end
     
     
    %Comprobar Orden
    X = s;
    Y = sort(s);
    if sum(X==Y) ~= size(s,2)
        valida = 0;
        disp('la mochila no es supercreciente, sus elementos no estan ordenados en orden creciente')
        return
    end
    %Fin Comprobar Orden
    
    %MOCHILA SUPERCRECIENTE
    
    for x = 2:size(s,2)-1
        aux = 0;
        for y = 1:x
            aux = aux + s(y);
        end
        if aux < s(x+1)
         flag = 1;
        else
         flag = 0;
         valida = flag;
         return
        end
    end
    %FIN MOCHILA SUPERCRECIENTE
    
    valida = flag;
end

