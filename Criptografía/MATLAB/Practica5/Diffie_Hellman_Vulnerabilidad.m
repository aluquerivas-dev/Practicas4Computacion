function Diffie_Hellman_Vulnerabilidad(g,p)
    if genera(g,p) ~= 0
   
        
        random_A = randi([1 p-1]);
        fprintf('A genera el numero aleatorio random_A: %d\n', random_A);

        pow_A = potencia(g, random_A, p);
        fprintf('A envia a B el producto: %d\n\n', pow_A);

        %INTRUSO

        fprintf('EL INTRUSO CAPTURA pow_A: %d, y lo guarda\n', pow_A);
        random_C = randi([1 p-1]);
        fprintf('EL INTRUSO GENERA cc: %d\n', random_C);
        pow_C = potencia(g, random_C, p);
        fprintf('EL INTRUSO ENVIA a B: %d\n', pow_C);
        fprintf('B piensa que le llega A\n\n');

       
        random_B = randi([1 p-1]);
        fprintf('B genera un número aleatorio %d', random_B);
        pow_B = potencia(g, random_B, p);
        fprintf('B envia a A : %d', pow_B);

        %El INTRUSO captura lo que envia B y le envia a A pow_C
        fprintf('EL INTRUSO CAPTURA pow_B: %d y lo guarda\n', pow_B);
        fprintf('EL INTRUSO ENVIA a A el mismo dato que le ha enviado a B: %d\n', pow_C);
        fprintf('A piensa que le llega de B\n\n');

        %A y B calculan las claves con el INTRUSO
        claveA = potencia(pow_C, random_A, p);
        claveB = potencia(pow_C, random_B, p);

        fprintf('A y B calculan sus claves con los datos que les llegan\n');
        fprintf('A cifrará con clave: %d\n', claveA);
        fprintf('B cifrará con clave: %d\n\n', claveB);

        fprintf('LABOR DEL INTRUSO\n\n');
        fprintf('El INTRUSO sabe que A cifrará con: %d\n', claveA);
        fprintf('El INTRUSO sabe que B cifrará con: %d\n', claveB);

    else
       disp('G no es generador');
    end
end

