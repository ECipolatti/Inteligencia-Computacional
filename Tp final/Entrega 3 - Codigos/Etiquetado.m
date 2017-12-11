function [ Centroides ] = Etiquetado( k , Data )
    [n, m] = size(Data);
    Centroides = zeros(k, m);
    for alpha = 1 : k
        patron = fix( alpha * n / k );  
        Centroides(alpha, :) = Data(patron, :);
    end
end

