function [S] = windows(P,prate,fitness)
    % selección por método de Ventanas
    % P:        población actual
    % prate:    tasa de progenitores a seleccionar
    % fitness:  fitness de cada individuo de la población
    
    [M,N] = size(P);
    R = round(M*prate);
%     l = logspace(1,0,k)/10;              % reducción del tamaño de ventana
    l = linspace(1,0,2*R);
    aux = sortrows([fitness P],-1);     % agrego fitness a la col. 1 y ordeno de mayor a menor    
    aux = aux(:,2:end);                 % saco el fitness
    S = zeros(R,N);                     % preparo los progenitores
    for i = 1 : R
        V = round(size(aux,1)*l(i));    % cantidad de elementos en la ventana
        r = randi([1 V],1,1);           % número al azar entre 1 y V
        S(i,:) = aux(r,:);              % tomo el elemento que salió elegido al azar
    end
end

% function [S] = windows(P,prate,fitness)
%     % selección por método de ventanas
%     [M,N] = size(P);
%     k = round(M*prate);
%     l = 1:-0.001:1/k;                   % reducción del tamaño de ventana
%     aux = sortrows([fitness P]);        % agrego fitness a la col. 1 y ordeno de mayor a menor    
%     aux = aux(:,2:end);                 % saco el fitness
%     S = zeros(k,N);                     % preparo los progenitores
%     i = 1;                              % contador de progenitor
%     while i <= k
%         V = round(size(aux,1)*l(i));    % cantidad de elementos en la ventana
%         r = randperm(V);                % permutación de V elementos
%         S(i,:) = aux(r(1),:);           % tomo el primer elemento de los V (permutado)
%         aux = aux(r(2:end),:);          % los restantes los paso a la siguiente ventana
%         i = i + 1;                      % incrementa el contador de progenitor
%     end
% end

