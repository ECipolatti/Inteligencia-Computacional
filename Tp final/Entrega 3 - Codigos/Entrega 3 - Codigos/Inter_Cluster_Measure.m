function [ InterCM ] = Inter_Cluster_Measure( Mu )
    % Se mide cuan separados estan los centroides de los distintos Clusters encontrados
    % por k_menas segun las semillas que se le haya dado. La idea es MAXIMIZAR la 
    % distancia entre los clusters, es decir, que los centroides esten 
    % lo mas lejos posible unos de otros
%     Mu=[1 2 3 4; 4 5 6 7;6 7 8 9];
    
    [k,~]=size(Mu);
    sum = 0;
    for i = 1 : k-1
        for j = i+1 : k
            sum = sum + norm(Mu(i,:) - Mu(j, :), 2);
        end
    end
    
    InterCM = sum / k;
    
end