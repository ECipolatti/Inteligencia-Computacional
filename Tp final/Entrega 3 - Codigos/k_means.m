function [ Mu, indices, iteraciones, time ] = k_means( k, Data, Seed )
    tic();
    [n, m] = size(Data);
    indices = ones(n, 1);
    Mu =  Seed;  
    bandera = 1; % 1 - cambio de indices
    iteraciones = 0;
    while (bandera == 1) && (iteraciones < 2000)
        iteraciones = iteraciones + 1;
        bandera = 0;
        for p = 1 : n    %  recorro los patrones
            d = dist2d(Data(p,:), Mu);
            [~, ind] = min(d);
            if indices(p) ~= ind
                indices(p) = ind;
                bandera = 1;
            end
        end
       
        % actualizo mis mu
        for i = 1 : k %recorro los mu
            prom_vec = zeros(1, m);
            c = 0;
            for j = 1 : n
                if indices(j) == i
                    c = c+1;
                    prom_vec = prom_vec + Data(j,:);
                end
            end
            if c ~= 0 
                Mu(i,:) = prom_vec/c;  
            end
        end
    end
    time = toc();
end

