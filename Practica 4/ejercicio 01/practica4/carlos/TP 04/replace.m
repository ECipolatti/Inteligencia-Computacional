function [P] = replace(P,S,elite,gap)
    % reemplazo de la población
    % P:        población inicial
    % S:        hijos generados por selección(ruleta, etc.) y variación (mutación y cruza)
    % elite:    índice del mejor de la población P
    P(1,:) = P(elite,:);            % el mejor de P pasa directo (elitismo)
    M = size(S,1);                  % cantidad de hijos (debiese ser igual a la de P)
    R = round(gap*M);               % cantidad de padres que pasan a la siguiente generación (brecha)
    r = randperm(M);                % permutación aleatoria de los M hijos
    P(2:R+1,:) = P(r(1:R),:);       % paso R padres a la próxima generación
    P(R+2:end,:) = S(r(R+1:end-1),:); % completo con hijos

end

