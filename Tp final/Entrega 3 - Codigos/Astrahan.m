function [ Seed ] = Astrahan( k, Data )
    [n, m] = size(Data);
    Seed = zeros(k,m);
    Punto_Minimo = min(Data);
    Punto_Maximo = max(Data);
    dist_Maxima = norm(Punto_Maximo - Punto_Minimo, 2)^2;
    q = ceil(dist_Maxima / k);
    d = [dist_Maxima (dist_Maxima - (1:k-1)*q)];
    
    Distancias = zeros(n, n);
    for i = 1 : n
        for j = 1 : n
            Distancias(i, j) = norm(Data(i, :) - Data(j, :), 2)^2;
        end
    end
 
    densidad = zeros(n, 1);
    for i = 1 : n
        densidad(i) = sum(Distancias(i, :) > d(1));
    end
    [lista_ordenada, O] = sort(densidad, 'descend');
    Seed = Data(O(1), :);
    c = 2;
    while c < k+1
        for i = 2 : length(O)
            aux = dist2d(Data(O(i), :), Seed).^2;
            if ( sum(aux > d(c)) == length(aux))
                Seed = [Seed; Data(O(i), :)];
                c = c + 1;
                if c == k+1
                    break;
                end
            end
        end
        c = c + 1;
    end
end