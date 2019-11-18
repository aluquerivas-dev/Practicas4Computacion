function V=letranumero(texto)
TAM=size(texto);
texto=lower(texto);
alfabeto='abcdefghijklmnnopqrstuvwxyz';
alfabeto(15)=char(241);
%V=zeros(1,TAM(2));
V=[];
for i=1:TAM(2)
    %Quitamos tildes
    switch texto(i)
        case 'á'
          texto(i)='a'
        case 'é'
          texto(i)='e'
        case 'í'
          texto(i)='i'
        case 'ó'
          texto(i)='o'
        case 'ú'
          texto(i)='u'
    end
          %
    for j=1:27
        if texto(i) == alfabeto(j)
            %V(i)=j-1;
            V=[V,j-1];
        end
    end
end
