% Función que permita al usuario (receptor) generar una clave privada y una clave pública
% adecuada a partir de una mochila supercreciente
% 
%     Entrada: mochila supercreciente. La función debe asegurarse que el vector es una
%                                      mochila supercreciente.
%     
%     Salidas:
%     
%         - cpubl: mochila trampa creada a partir de s y de los valores mu y w. Para ello:
%         - El valor mu debe introducirlo el usuario, por lo que se lo debe pedir la función. Debe
%         ser adecuado, para ello basta con que sea superior al doble del último elemento de s.
%         - El valor w lo buscara la función asegurándose que tenga inverso módulo mu y que no
%         tenga factores comunes con los elementos de s.
%         cpriv: un vector fila de dos elementos: mu y el inverso de w módulo mu.

function [cpubl, cpriv]=mochila_mh(s)

    if mochila(s) == 1
        fprintf('Necesitamos un entero MAYOR QUE %d \n', max(s)*2);
        flag = 0;
        mu = 0;
        %ASEGURAMOS UN BUEN VALOR DE MU
        while (flag==0)
            mu = input('\nValor de mu: ');
            if mu<=(max(s)*2)
                fprintf('\nEl valor de mu introducido no es válido por un mínimo de %d unidades \n',(max(s)*2+1)-mu)
            else
                flag = 1;
            end
        end
        
       flag = 0;
       INDICE = 2;
       W = 0;
       while (flag==0)
            if gcd(mu, INDICE) == 1%Tiene Inverso
                if factorescomunes(INDICE,s) == 0 %El w sera el INDICE
                    W = INDICE;
                    flag = 1; 
                end     
            end
            INDICE = INDICE + 1;
       end
       W
       %Ahora hallamos la inversa de w en mu
        [G, U, invw] = gcd(mu, W);
        cpriv(1) = mu;
        cpriv(2) = mod(invw,mu);
        
        %Y calculamos la mochila

        AUX =  [];
        for i=1:length(s)
            AUX = [AUX, mod(s(i)*W, mu)];
        end
        cpubl = AUX;
    
       
    end
end

