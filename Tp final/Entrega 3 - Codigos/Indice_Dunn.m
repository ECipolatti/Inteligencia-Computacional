function [ ind_Dunn ] = Indice_Dunn( Clusters )
    % En este caso voy a trabajar con el Diametro de cada cluster que es la maxima
    % distancia que exista entre un patron y su centroide.
    % Y con la distancia entre dos clusters que es medida como la minima
    % distancia entre todos los puntos de ambos clusters
    % La idea es maximizar este indice ya que al dividir por el mayor diametro encontrado
    % entre todos los clusters, cuanto mas chico sea el denominador, mayor sera el indice
    % indicando que los clusters son compactos y cohesivos
    
    D = Diametros(Clusters);
    M = Distancia(Clusters);
    
    ind_Dunn = M / max(D);   
    
end

