function v=fibonacci(a,b,n)
v=zeros(1,n);
v(1:2) = [a b];
for i=3:n
    v(i)= v(i-1)+v(i-2);
end