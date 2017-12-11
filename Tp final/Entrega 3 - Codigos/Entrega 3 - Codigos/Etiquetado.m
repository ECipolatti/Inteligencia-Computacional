function [ Centroides ] = Etiquetado( k , Data )
    [n, m] = size(Data);
    ind = 1 : 1 : n;
    Centroides = zeros(k, m);
    for i = 1 : k
        patron = fix( (i * length(ind)) / k );
        Centroides(i, :) = Data(patron, :);
    end
    
end

