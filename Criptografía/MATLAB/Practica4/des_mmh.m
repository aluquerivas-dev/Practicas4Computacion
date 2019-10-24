function texto=des_mmh(s,cifrado,mu,invw)

%Se multiplica el cifrado por la inversa de w asi obtenemos la clave privada utilizada para descifrar
cifrado = mod(cifrado*invw, mu);

%Desciframos con el metodo de la mochila supercreciente
texto = des_mochila(s, cifrado);

end

