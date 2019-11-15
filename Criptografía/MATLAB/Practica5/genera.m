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
function generador = genera(g, p)
tic
    if isNat(g)==1
        
        if g<p && g>0 && isprime(p)
        
            q = p-1;
            F = factor(q);

            %Se tiene que cumplir que tenga para ser generador
            % desde 1 hasta p-1 debe de generarlos en sucesivas
            % potencias.
            for i=1:length(F)
                pote = uint64(potencia(g,q/F(i),p));

                %Buscamos si ya esta repetido
                if pote == 1
                    disp('g no es generador.')
                    generador = 0;
                    toc
                    return;
                end
            end
            toc
            generador = g;
            return
        else
           disp('el número p debe de ser primo y g menor que p y mayor que cero.')
           generador = 0
           return
        end
        
    else
        disp('G debe de ser natural.')
        generador = 0
        toc
        return 
    end

