% Función que usa el algoritmo de potenciación rápida para calcular las
% potencias modulares.

%   Entradas:
%       c: base de la potencia. Un número natural.
%       d: exponente de la potencia. Un número natural.
%       n: módulo. Un número natural.
%  
%   Salida: pote es la potencia c d módulo n.
function pote=potencia(c, d, n)

    if isNat(c)==1 && isNat(d)==1 && isNat(n)==1
            
     array_bin = dec2bin(d) 	
     disp(array_bin)
     pote = 1;
     variable = mod(c,n); 
     for i=length(array_bin):-1:1
         
         if array_bin(i) == '1'
             pote = uint64(mod(pote*variable,n));
         end
         variable = uint64(mod(variable*variable,n));
     end
        
    else
        disp('Alguna de las entradas no es natural.')
    end
   
    
    
    
    
end

