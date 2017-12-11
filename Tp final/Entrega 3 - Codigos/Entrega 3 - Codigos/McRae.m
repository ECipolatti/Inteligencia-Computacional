function [ Centroides ] = McRae( k, Data )
    [~, m] = size(Data);
    Centroides = zeros(k, m);
    c = 1;
    while c < k + 1
        ind = randi(length(Data));
        Centroides(c, :) = Data(ind, :);
        Data(ind, :) = [];
        c = c + 1;
    end
end

