function [ Centroides] = k_mean_plus_plus( k, Data )
    [n, m] = size(Data);
    Centroides = zeros(k,m);        %inicializo los k centroides
    ind = randi(n);                 % primer centroide elegido random entre los n patrones
    Centroides(1,:) = Data(ind,:);  % primer centroide seleccionado
    for i = 2:k                     % selecciono los k-1 centroides restantes                       
        P = zeros(length(Data),1);                      % P: vector probabilidad
        for j=1:length(Data)                            % Recorro todos los patrones
            P(j) = min(dist2d(Data(j,:),Centroides));   % Determino la probabilidad de ser centroide
        end
        P = P/sum(P);                                   % Probabilidad de cada patron
        ind = Probabilidad(P);                          % Elemento ganador
        Centroides(i,:) = Data(ind,:);                  % Agrega un nuevo centroide
    end
end

