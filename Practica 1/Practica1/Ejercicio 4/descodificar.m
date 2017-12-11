function [ Ydeco ] = descodificar( Y )
    [n m] = size(Y);
    Ydeco = zeros(n,m);
    for i=1:n
        for j=1:m
            if Y(i,j) == max(Y(i,:))
                Ydeco(i,j) = 1;
            else
                Ydeco(i,j) = -1;
            end
        end
    end
end

