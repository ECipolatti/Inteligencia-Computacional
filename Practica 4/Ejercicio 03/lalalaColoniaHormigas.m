close all; clear all; clc;
addpath('../Datos');
D = csvread('10cities.csv');
[n, m] = size(D);

method = 'g'; %Puede ser 'g' (global), 'u' (uniforme) o 'l' (local)

N = 50; % Cantidad de hormigas
b = 1;
sigma = b * rand(n, m);

Q = 1;
origen = 5;
beta = 1;
alpha = 1;
evap = 1 - 0.1;
tic();
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

    % Condicion de corte por caminos iguales    
%     [val, ind] = min(costo);
%     if (MejorCosto > val)
%         MejorCosto = val;
%         MejorCamino = p(ind, :);
%     end
    cantferomonas = zeros(size(sigma, 1), 1);
    for i = 1 : size(sigma,2)
        cantferomonas(i) = sum(sigma(i,:));
    end
    [val, ind] = max(cantferomonas);
    MejorCamino = p(ind, :);
    CostoCamino = costo(ind);
    iter = iter+1;
end

time = toc();
fprintf('tiempo requerido: %d seg \n',time)
fprintf('Mejor camino encontrado es: %s \n',num2str(MejorCamino))
fprintf('Costo del camino encontrado: %d \n',CostoCamino)
    
