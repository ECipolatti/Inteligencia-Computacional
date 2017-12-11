clear all; close all;

fd = csvread('datos/XOR_trn.csv');
P = length(fd);
n_inputs = 2;
n_outputs = size(fd,2) - n_inputs;

pass = 10;      % cantidad inicial de pasadas
asig = 1;       % cantidad inicial de asignaciones (1 pasada por lo menos)

K = 4;
% inicializo la matriz de medias con valores aleatorios de entradas
K_idx = randperm(P,K);  % K índices aleatorios entre 1 y P
mu = fd(K_idx,1:n_inputs);
P_idx = ones(1,P);      % vector de índices para ir reasignando patrones

while asig ~= 0 && pass > 0
    asig = 0;               % resetea el contador de asignaciones
    for i = 1 : P
        dist = zeros(1,K);
        for k = 1 : K
            dist(k) = norm(fd(i,1:n_inputs) - mu(k,:));
        end
        [~,l] = min(dist);
        if P_idx(i) ~= l
            P_idx(i) = l;
            asig = asig + 1;
        end
        
        % recalculo las medias
        for k = 1 : K
            mu(k,:) = mean(fd(find(P_idx == k),1:n_inputs));
        end
    end
    
    pass = pass - 1;    % decrementa el contador de pasadas
end