function [ MejorCamino, CostoCamino ,time] = ColoniaHormigas( N, Q, rho, alpha, beta, D, origen, method )

    tic();
    [n, m] = size(D);
    sigma = ones(n,m);
    evap = 1 - rho;
    
    MejorCamino = zeros(1, size(D,1)+1);
    MejorCosto = 1000000;
    aux = 0; % zeros(n, m);
    p = zeros(N, size(D,1)+1);
    max_iter = 5000;
    iter = 0;
    
    while (~isequal(p,aux)) && (iter < max_iter)
        aux = p;
        costo = zeros(N, 1);
        for k = 1 : N % Para cada Hormiga k - 3.1
            pk = [origen];
            nodos = [1 : n];
            nodos(origen) = [];
            
            while (size(nodos,2) ~= 0)
                prob = zeros(1, length(nodos));
                for j = 1 : length(nodos)
                    numerador = sigma(pk(end), j)^alpha / D(pk(end), nodos(j))^beta;
                    denominador = sum(sigma(pk(end), nodos).^alpha ./ D(pk(end), nodos).^beta);
                    prob(j) = numerador / denominador;
                end
                if (length(nodos) == 1)
                    pk = [pk nodos];
                    nodos = [];
                else
                    prob = cumsum(prob);
                    a = rand();
                    proximo_nodo = buscar(prob, a);
                    pk = [pk nodos(proximo_nodo)];
                    nodos(proximo_nodo) = [];
                end
                
            end
            % Calculo de la longitud del camino encontrado por la hormiga k - 3.1.3
            pk = [pk origen];
            costo(k) = distancia(pk, D);
            p(k, :) = pk;
        end
        
        sigma = sigma * evap; % paso 3.2
        switch method
            case 'g' % Global
                for i = 1 : n
                    for j = 1 : m
                        sigma(p(i,j), p(i,j+1)) = sigma(p(i,j), p(i,j+1)) + Q / distancia(p(i,:), D);
                    end
                end
            case 'u' % Uniforme
                for i = 1 : n
                    for j = 1 : m
                        sigma(p(i,j), p(i,j+1)) = sigma(p(i,j), p(i,j+1)) + Q;
                    end
                end
            otherwise  % Local
                for i = 1 : n
                    for j = 1 : m-1
                        sigma(p(i,j), p(i,j+1)) = sigma(p(i,j), p(i,j+1)) + Q / D(p(i,j), p(i,j+1));
                    end
                end
        end

        cantferomonas = zeros(size(sigma, 1), 1);
        for i = 1 : size(sigma,2)
            cantferomonas(i) = sum(sigma(i,:));
        end
        [val, ind] = max(cantferomonas);
        MejorCamino = p(ind, :);
        CostoCamino = costo(ind);
        iter = iter+1;
    end
    time=toc();
end

