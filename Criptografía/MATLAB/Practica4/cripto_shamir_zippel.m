function cripto_shamir_zippel(cp, mu)
%Iniciamos funcion de tiempo
tic
    [G, U, V] = gcd(cp(2), mu);
    q = mod(cp(1) * V, mu);

    RANGOS = [];
    flag = 0;
    VRANGE=0;
    
        while flag==0
            rango = 2^((length(cp)+1)+VRANGE);
            fprintf('Vamos a buscar en el rango [1 %d]\n', rango);
            %Rellenamos el vector de rangos para luego buscar el mas pequeño
            for i=1:rango
               RANGOS = [RANGOS, mod(i * q, mu)];
            end
            RANGOS = sort(RANGOS);
               %Lo ordenamos para probar con los valores mas pequeños del rango
            for i=1:length(RANGOS)
                CANDIDATO_S1 = RANGOS(i);
            
                    
                    [G, U, V] = gcd(mu, CANDIDATO_S1);
                    W = mod(cp(1) * V, mu);
                    %Calculado ya w, hacemos el calculo de su inverso y
                    %sacamos la mochila
                    [G, U, INVERSO_W] = gcd(mu, W);
                    %Aplicamos winv a toda la mochila
                    MOCHILA = mod(cp * INVERSO_W,mu);
                    %Una vez tenemos la mochila, comprobamos que es supercreciente, si
                    %es supercreciente hemos terminado
                    if mochila(MOCHILA) == 1
                        disp('Mochila: ');
                        disp(MOCHILA);
                        %Finalizamos funcion de tiempo
                        toc
                        return;
                    end
            end
            %Aqui le pedimos al usuario si desea ampliar el rango
            prompt = 'No se encontro la mochila, pulse (1) para ampliar rango en 1 unidad , pulse (0) para acabar:  ';
            ENTRADA = input(prompt);
            if ENTRADA==1
                VRANGE = VRANGE+1;
            else
                flag = 1;
            end
        end
end