function [B]=findV(M,v)
    %Busca un vector fila v dentro de la matriz M
[n,m]=size(M);
B=true;
for i=1:n
    for j=1:m
        if M(i,j)~=v(j)
            B=false;
            break
        end
    end
    if B
        return;
    end
    B=true;
end
B=false;
end
