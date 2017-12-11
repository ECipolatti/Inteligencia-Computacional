function [ ind_DB ] = Indice_DB( Mu, ICM )
    % Este indice es una relacion entre la suma Intra e Inter cluster.
    % Se calcula el Indice tomande de a pares de clusters. En el calculo 
    % del indice, el numeros es la suma de los valores Intra de cada cluster.
    % En el denominador se calcula la distacia entre los centroides de los clusters en cuestion
    % La idea es obtener el minimo valor posible para este Indice, ya que el numerador indica cuan
    % compactos son los clusters y el denominador indica cuan alejados estan unos de otros
    % Devuelvo un vector con los ind_DB de cada cluster
    n = length(ICM);
    acum = 0;
    for i = 1 : n-1
        for j = i+1 : n
            acum = acum + ( ( ICM(i) + ICM(j) ) / ( norm(Mu(i, :) - Mu(j, :), 2) ) );
        end
    end
    ind_DB = acum / n;    
end