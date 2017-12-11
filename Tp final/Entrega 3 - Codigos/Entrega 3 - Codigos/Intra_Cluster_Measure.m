function [ IntraCM ] = Intra_Cluster_Measure(clusters)
    % afuera tengo que hacer la suma de los ICM de todos los clusters,
    % dividido el numero de clusters (K)
    
    % calcula la suma de las distancias euclideas de los vectores de
    % centroides
    
    
    IntraCM =0;
    for c=1:length(clusters) 
        [n, ~] = size(clusters{c}.C);
        ICM = 0;
        for i = 1 : n-1
            for j = i+1 : n
                ICM = ICM + norm( clusters{c}.C(i,:) - clusters{c}.C(j,:), 2);
            end
        end
        if n~=0
            ICM = ICM / n;
            IntraCM = IntraCM + ICM;
        end
    end
    IntraCM = IntraCM/c;
end