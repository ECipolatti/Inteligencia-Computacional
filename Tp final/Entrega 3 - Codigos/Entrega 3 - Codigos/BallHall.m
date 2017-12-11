function [ Centroides ] = BallHall( k, Data )
    [n, m] = size(Data);
    Centroides = zeros(k, m);
    Centroides(1, :) = mean(Data);

    d = 10;
    c = 2;
    while c < k+1
        for i = 1 : n
            if (pasaOno(Centroides, Data(i, :), d))
                Centroides(c, :) = Data(i, :);
                c = c+1;
                if (c < k+1)
                    continue;
                else
                    break;
                end
            else
                continue;
            end
        end
        break;
    end       
end


