% 
% Funci�n para comprobar si un n�mero w tiene factores primos comunes con los elementos de
% la mochila s, porque en caso de tener no ser� un buen n�mero que act�e como factor entre la
% mochila simple y la mochila trampa.
% 
%     Entradas:
% 
%         w: un n�mero entero.
%         s: una mochila. Aunque para el cifrado deber� ser supercreciente, para implementar
%         esta funci�n no debe serlo necesariamente.
%         Salida: factores_c=0 si no hay factores comunes.
%         factores_c=1 si hay factores comunes, junto con un mensaje que indique con que
%         elementos de la mochila tiene factores comunes.



function factores_c = factorescomunes(w,s)

   
    FACTORES = [];
    FACTORES_W = factor(w);
    %La idea es recorrer cada factor de w y compararlo con cada factor de
    %cada numero de s, si alguno coincide son factores, se guardan en
    %vector que luego se comvertira en unico para evitar valores repetidos.
    for i=1:length(FACTORES_W)
        %Comprobamos cada factor de la mochila
        for j=1:length(s)
           FACTORES_S = factor(s(j));
           
           for k=1:length(FACTORES_S)
               
               if(FACTORES_W(i) == FACTORES_S(k))
                   FACTORES = [FACTORES,s(j)];
               end
               
           end
        end
    end
    
    
    if isempty(FACTORES)
        factores_c = 0;
    else
        disp('los numeros de la mochila con factores comunes a w son')
        FACTORES = unique(FACTORES)
        factores_c = 1;
    end
end