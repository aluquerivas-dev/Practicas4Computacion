% Función que indica si el número natural g es generador del grupo
% multiplicativo determinado por el primo p. Para ello utilizaremos la definición
% de generador.
% Entradas:
% g: número natural de Zp, a decidir si es generador.
% p: número primo que determina el grupo multiplicativo.
% Salida:
% generador=0: en caso de que no sea generador o las entradas no
% sean correctas.
% generador=g: en caso de que sea generador.
% También nos debe mostrar el tiempo que tarda en decidir si el
% elemento es generador.
function generador = genera_0 (g, p)
tic
    if isNat(g)==1
        
        Array = []
        
        %Se tiene que cumplir que tenga para ser generador
        % desde 1 hasta p-1 debe de generarlos en sucesivas
        % potencias.
        for i=1:p-1
            pote = uint64(potencia(g,i,p))
            
            %Buscamos si ya esta repetido
            if find(Array == pote)
            generador = 0;
            toc
            return;
            else
                Array = [Array,pote];
            end
            
        end
        toc
        generador = g
        return
        
    else
        disp('G debe de ser natural.')
        generador = 0
        toc
        return 
    end

end

