function inver = inv_modulo(A,m)
 [f,c]=size(A);
if f~=c  
    inver=0;
    error('Es necesaria la entrada de una matriz cuadrada')
    return
else
    
    if ~isequal(A,round(A) )
            inver =0;
            error('La matriz no tiene todos los elementos enteros')
            return
    else
            A=mod(A,m);
            DETERMINANTE=round(mod(det(A),m));
            [G ,U ,V] = gcd(m,DETERMINANTE);
            
            if(G==1) % Sicnifica que el maximo comun divisor entre el el modulo y el determinante de A es 1 y se puede calcular la inversa
                    X=mod(det(A)*inv(A),m);
                    INVERSO=mod(V,m);
                    inver=mod(INVERSO*X,m);
                    inver=round(inver);
            else
                    error('La matriz notiene inversa en modulo -->> %d \n',m)
                    inver=0;
            end
    end
end

