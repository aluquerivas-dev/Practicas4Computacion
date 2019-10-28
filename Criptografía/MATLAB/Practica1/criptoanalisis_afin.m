% Esta función realiza el criptoanálisis de un mensaje, que ha sido cifrado con afín, 
% pero del que no conocemos las claves.
% 
%     Entradas:v: criptograma.m: módulo de trabajo.
%     
%     Salida: Compara las máximas frecuencias, descifra el mensaje y nos dice 
%     que si queremos probar con otras claves. Si decimos que sí, 
%     pasa a las siguientes frecuencias y nos muestra el nuevo posible 
%     mensaje claro.......hasta que le digamos que no lo intente con otras 
%     claves porque ya tengamos el texto claro.
% 
%     Al final debo tener el mensaje claro y el valor de las claves que se 
%     han usado para cifrarlo.
function criptoanalisis_afin(v, m)
[frecuencia, freordenada] = cripto_ana_orden(v);

ABC = 'abcdefghijklmnnopqrstuvwxyz';

ABC(15) = char(241);

%Frecuencia de las letras
FE = [0.1311 4; 0.106 0; 0.0847 19; 0.0823 15; 0.0716 8; 0.0714 13; 0.0695 18; 0.0587 3; 0.054 20; 0.0485 2; 0.0442 11; 0.0434 21; 0.0311 12; 0.0271 16; 0.014 6; 0.0116 1; 0.0113 5; 0.0082 22; 0.0079 25; 0.0074 17; 0.006 7; 0.0026 26; 0.0025 9; 0.0015 24; 0.0012 23; 0.0011 10; 0.001 14];

flag = 0;

    for i=1:length(freordenada)
        for j=1:length(FE)
            
            %Solo controlamos el caso donde sean i y j diferentes
            if i~= j
                %Se deben seleccionar los dos caracteres mas frecuentes en
                %FE y en la frase introducida.
                %Se debe de crear un sistema de ecuaciones para despejar
                x1 = round(FE(i,2));
                x2 = round(FE(j, 2));
                y1 = round(freordenada(i,2));
                y2 = round(freordenada(j,2));
                B = [x1 1;x2 1];
                C = [y1; y2];
                %antes de nada debemos de comprobar si va a tener inversa, puesto
                %que si no tiene inversa nos saltamos esa clave y pasamos a la
                %siguiente
                
                B = mod(B, length(ABC));
                DETERMINANTE=round(mod(det(B),length(ABC)));
                [G ,U ,V]=gcd(length(ABC),DETERMINANTE);
                
                %Si G==1 tiene inversa
                if(G==1)
                    
                    B = inv_modulo(B, length(ABC));
                    A = B*C;
                    %Sacamos la clave y el elemento d
                    clave = mod(A(1,1), length(ABC));
                    d = mod(A(2,1), length(ABC));
                    
                    %Llamamos a la funcion desafin con la clave y la d
                    if gcd(clave, length(ABC)) == 1
                        fprintf('CLAVE: %d:\n', clave);
                        fprintf('D %d:\n', d);
                        descifradoafin = desafin(clave, d, v)
                    else
                        disp('La clave creada no es valida')
                    end
                    prompt = 'Si quieres probar otra clave introduce 1, en caso contrario introduce 0 ->';
                    flag = input(prompt);
                end

                if flag == 0
                    return
                end   
            end
        end
end
