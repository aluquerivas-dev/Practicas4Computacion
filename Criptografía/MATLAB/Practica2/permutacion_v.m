function permuta = permutacion_v(p)
    X = [1:size(p,2)];
    Y = sort(p);
    if X == Y
        disp('Efectivamente has introducido una permutaci�n')
        permuta = 1;
    else
        disp('Error en entrada de de la permutaci�n')
        permuta = 0;
    end
end

