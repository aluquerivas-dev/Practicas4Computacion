function permuta = permutacion_v(p)
    X = [1:size(p,2)];
    Y = sort(p);
    if X == Y
        disp('Efectivamente has introducido una permutación')
        permuta = 1;
    else
        disp('Error en entrada de de la permutación')
        permuta = 0;
    end
end

