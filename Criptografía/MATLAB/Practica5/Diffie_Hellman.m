function Diffie_Hellman(g, p)
    % G debe ser del conjunto de generador con el pripo P
    if genera(g,p) ~= 0
        %Generamos el de manera aleatorio los valores de A y B
        
        random_A = randi([1 p-1]);
        fprintf('A genera el numero aleatorio random_A: %d\n', random_A);
        
        pow_A = potencia(g, random_A, p);
        fprintf('A envia a B el producto: %d\n', pow_A);
        
        random_B = randi([1 p-1]);
        fprintf('B genera el numero aletorio random_B: %d\n\n', random_B);
        
        pow_B = potencia(g, random_B, p);
        fprintf('B envia a A el producto: %d\n\n', pow_B);


        %Ultimo paso A y B calculan la clave con la que poder cifrar

        pass_A = potencia(pow_B, random_A, p);
        fprintf('La clave que obtiene A es: %d\n', pass_A);
        pass_B = potencia(pow_A, random_B, p);
        fprintf('La clave que obtiene B es: %d\n', pass_B);

    else
       disp('G no es generador');
    end
end