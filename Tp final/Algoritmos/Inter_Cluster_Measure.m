function [InterCM]=Inter_Cluster_Measure(V, V_media)
    %afuera tengo que hacer la suma de los ICM de todos los clusters,
    %dividido el numero de clusters (K)
    
    %calcula la suma de las distancias euclideas de los vectores a un 
    %vector de medias (v_medias)
    [n,~]=size(V);
    InterCM = 0;
    for i=1:n
        InterCM = InterCM + norm(V(i,:) - V_media, 2);
    end
    
end