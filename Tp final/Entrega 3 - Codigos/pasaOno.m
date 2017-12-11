function [ bool ] = pasaOno( Centroides, Patron, d )
    [n, m] = size(Centroides);
    aux = zeros(n, 1);
    for i = 1 : n
        if ( (dist2d(Centroides(i, :), Patron))^2 > d )
            aux(i) = 1;
        end
    end
    
    if sum(aux) == n
        bool = true;
    else
        bool = false;
    end
end

