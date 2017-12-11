function [ InterCM ] = Inter_Cluster_Measure( Mu )
    % Se mide cuan separados estan los centroides de los distintos Clusters.
    % La idea es MAXIMIZAR esta distancia, es decir, que los centroides esten 
    % lo mas lejos posible unos de otros
    
    [k, ~] = size(Mu);
    sum = 0;
    for i = 1 : k-1
        for j = i+1 : k
            sum = sum + norm(Mu(i,:) - Mu(j, :), 2);
        end
    end
    InterCM = sum / k;
end