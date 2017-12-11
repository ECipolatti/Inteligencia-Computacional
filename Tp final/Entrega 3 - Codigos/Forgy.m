function [ Centroides ] = Forgy( k, Data )
    [n, m] = size(Data);
    Centroides = zeros(k, m);
    Data = Data(randperm(n), :);
    n_por_grupo = round(n / k);
    i = 1;
    c = 1;
    while c < k+1
        if ( (i + n_por_grupo -1 ) > n )
            Centroides(c, :) = mean(Data(i:end, :));
        else
            Centroides(c, :) = mean(Data(i : i + n_por_grupo -1, :));
        end
        i = i + n_por_grupo;
        c = c + 1;
    end
end

