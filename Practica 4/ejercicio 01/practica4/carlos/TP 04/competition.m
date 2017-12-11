function [S] = competition(P,prate,k,fitness)
    % selección por método de competencia
    [M,N] = size(P);
    aux = [fitness P];                  % agrego el fitness
    R = round(M*prate);                 % cantidad de progenitores a seleccionar
    S = zeros(R,N);                     % preparo la matriz de progenitores
    
    for i = 1 : R
        r = randperm(size(aux,1));      % permutación de elementos actuales de la población
        [~,m] = max(aux(r(1:k),1));     % el de mayor fitness de los k elegidos
        S(i,:) = aux(r(m),2:end);       % tomo el ganador
    end
end

%% Variante con participación de una única vez del progenitor seleccionado
% function [S] = competition(P,k,fitness)
%     selección por método de competencia
%     [M,N] = size(P);
%     S = zeros(k,N);                     % preparo los progenitores
%     i = 1;                              % contador de progenitor
%     aux = [fitness P];                  % agrego el fitness
%     while i <= k
%         r = randperm(size(aux,1));      % permutación de elementos actuales de la población
%         group_in = aux(r(1:k),:);       % tomo los k primeros (permutados)
%         group_out = aux(r(k+1:end),:);	% los que quedaron afuera de la competencia
%         [~,m] = max(group_in(:,1));     % el de mayor fitness de los k elegidos
%         S(i,:) = group_in(m,2:end);     % tomo el ganador
%         aux = [ group_in(1:m-1,:);...   % los restantes los paso a la siguiente competencia
%                 group_in(m+1:end,:);...
%                 group_out];
%         i = i + 1;                      % incrementa el contador de progenitor
%     end
% end
