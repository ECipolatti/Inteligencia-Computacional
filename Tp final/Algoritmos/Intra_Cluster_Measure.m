function [IntraCM]=Intra_Cluster_Measure(V)
    %afuera tengo que hacer la suma de los ICM de todos los clusters,
    %dividido el numero de clusters (K)
    
    %calcula la suma de las distancias euclideas de los vectores de
    %centroides
    [n,~]=size(V);
    IntraCM = 0;
    for i=1:n
        for j=1:n
            IntraCM = IntraCM + norm(V(i,:) - V(j,:), 2);
        end
        
    end
    IntraCM = IntraCM/i
end