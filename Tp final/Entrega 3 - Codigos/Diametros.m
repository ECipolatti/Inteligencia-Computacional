function [ D ] = Diametros( Clusters )
    % Diametro de los Clusters
    [~, m] = size(Clusters);
    D = zeros(m, 1);
    for i = 1 : m
        [o, ~] = size(Clusters{i}.C);
        maxima = 0;
        for j = 1 : o-1
            for k = j+1 : o
                aux = norm(Clusters{i}.C(j,:) - Clusters{i}.C(k,:), 2);
                if (aux > maxima)
                    maxima = aux;
                end
            end
        end
        D(i) = maxima;
    end

end

