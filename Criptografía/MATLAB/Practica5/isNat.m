function flag = isNat(number)
    if number>0 && mod(number,1)==0
        flag = 1;
    else
        flag = 0;
    end
end

