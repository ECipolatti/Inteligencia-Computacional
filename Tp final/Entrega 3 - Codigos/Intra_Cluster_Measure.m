function [ IntraCM, ICM ] = Intra_Cluster_Measure( Clusters, Mu)
    % La distancia INTRA CLUSTER se mide como el promedio de la suma
    % de las distancias de cada patron del cluster con respecto a su Centroide.
    % Se devuelve un promedio de los valores Intra Cluster encontrados
    % Devuelvo ICM que es la Dispersion en cada Cluster. Esto lo ocupo en el ind_DB
    
    IntraCM = 0;
    ICM = zeros(length(Clusters), 1);
    for c = 1 : length(Clusters)
        [n, ~] = size(Clusters{c}.C);
        if n ~= 0
            ICM_aux = 0;
            for i = 1 : n
                ICM_aux = ICM_aux + norm(Clusters{c}.C(i,:) - Mu(c, :), 2);
            end
            ICM(c) = ICM_aux / n;
            IntraCM = IntraCM + ICM(c);
        end
    end
    IntraCM = IntraCM / c;
end