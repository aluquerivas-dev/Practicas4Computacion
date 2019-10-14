function permuta = permutacion_v(p)
    X = [1:size(p,2)];
    Y = sort(p);
    if X == Y
        permuta = 1;
    else
        permuta = 0;
    end
end

