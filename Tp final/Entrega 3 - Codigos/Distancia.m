function [ minima ] = Distancia( Clusters )
    % La distancia entre dos Clusters la calculo como min{d(x, y)}
    % siendo x perteneciente al primer Cluster e y al segundo
    
    [~, l] = size(Clusters);
    c = 1;
    minima = inf;
    while c < l
        x = size(Clusters{c}.C, 1);
        y = size(Clusters{c+1}.C, 1);
        for i = 1 : x
            for j = 1 : y
                aux = norm(Clusters{c}.C(i, :) - Clusters{c+1}.C(j, :), 2);
                if (aux < minima)
                    minima = aux;
                end
            end
        end
        c = c + 1;
    end
end

