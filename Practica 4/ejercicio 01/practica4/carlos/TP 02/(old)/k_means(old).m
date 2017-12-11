function [index,cent] = k_means(X,K)
    [P,N] = size(X);                       % P: cant. patrones; N: cant. columnas
    K = 5*K;
    max_pass = 100;
    pass = max_pass;
    
    index = zeros(P,1);                     % para almacenar el centroide para cada patrón
    for i = 1 : P
        index(i) = randperm(K,1);
    end

    cent = zeros(K,N);
    for j = 1 : K
        Cj = find(index == j);
        cent(j,:) = mean(X(Cj,:));
    end
    
    % inicializo el contador de reasignaciones sólo para que entre al menos una
    % vez al bucle while
    asig_ctr = max_pass;
    while (pass > 0 && asig_ctr > 0)
        scatter(cent(:,1),cent(:,2));
        % inicializo el contador de asignaciones. si al final del bucle for
        % sigue en cero, no hubo reasignaciones y sale del bucle while
        asig_ctr = 0;
        for i = 1 : P
           dist = zeros(1,K);
           for j = 1 : K
               dist(j) = norm(X(i,:)-cent(j,:));
           end

           [~,l] = min(dist);
           if l ~= index(i)
               index(i) = l;
               asig_ctr = 1;
           end
        end

        for j = 1 : K
            Cj = find(index == j);
            cent(j,:) = mean(X(Cj,:));

        end

        pass = pass -1;
    end
    
    cent = cent(~isnan(cent(:,2)),:);
end

