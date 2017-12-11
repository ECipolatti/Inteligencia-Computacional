clear all; close all;
addpath('./Datos');

% N = 50;                    % # Number of points
% V = [0, 0; 2, 2; 3, 0];  % # Triangle vertices, pairs of (x, y)
% t = sqrt(rand(N, 1));
% s = rand(N, 1);
% nube1 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);
% 
% N = 50;                    % # Number of points
% V = [2, 0; 3, 6; 4, 4];  % # Triangle vertices, pairs of (x, y)
% t = sqrt(rand(N, 1));
% s = rand(N, 1);
% nube2 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);
% 
% N = 50;                    % # Number of points
% V = [4, 0; 5, 4; 6, 2];  % # Triangle vertices, pairs of (x, y)
% t = sqrt(rand(N, 1));
% s = rand(N, 1);
% nube3 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);
% 
% N = 50;                    % # Number of points
% V = [7, 4; 8, 6; 9, 4];  % # Triangle vertices, pairs of (x, y)
% t = sqrt(rand(N, 1));
% s = rand(N, 1);
% nube4 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);
%  
% Data = [nube1 ; nube2; nube3; nube4];

% scatter(Data(:,1), Data(:,2),'r','.');
% hold on;

% La idea es usar cada uno de los metodos con el fin de encontrar semillas que sirvan
% de buena inicializacion para los Mu que k-means usa para armar los clusters. Luego,
% se miden las caracteristicas de cada cluster para ver que tan buenos son.

k = 4;
D = csvread('OR_trn.csv');
Daux = D(:, 1 : end-1);
Centroides = k_mean_plus_plus(k, Daux);
scatter(Daux(:, 1), Daux(:, 2), 'b', '.');
hold on;
scatter(Centroides(:, 1), Centroides(:, 2), 'k', 'b');

[Mu, indices] = k_means(k, Daux, Centroides);
scatter(Mu(:,1), Mu(:,2), 'r', 'x');
Aux = [Daux indices];

for i = 1 : k
    aux = Aux( Aux(:, end) == i, : );
    Clusters{i}.C = aux;
end

p = zeros(1, k);
for i = 1 : k
    p(i) = purity(Clusters{i}.C);
end


% Centroides = k_mean_plus_plus(4,Data);
% Centroides = McRae(k, Data);
% Centroides = Etiquetado(k, Data);
% Centroides = Forgy(k, Data);
% Centroides = BallHall(k, Data);





 