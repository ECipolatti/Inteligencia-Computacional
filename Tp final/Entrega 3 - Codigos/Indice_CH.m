function [ ind_CH ] = Indice_CH( k, Data, Clusters, Mu )
    % Nuevamente se presenta una relacion entre valores INTRA e INTER
    % entre los clusters. Pero en este caso se suman o acumulan ambos valores 
    % en dos variables B y W. Cuanto mayor sea el valor de B, mas alejados estan
    % los clusters unos de otros. Y cuanto menor sea el valor de W mas compactos
    % seran los clusters encontrados.
    % N es la cantidad de elementos en la base de datos
    % k es la cantidad de clusters
    [N, ~] = size(Data);
    z = mean(Data);
    [~, q] = size(Clusters);
    W = 0; 
    B = 0;
    for l = 1 : q
        [nl, ~] = size(Clusters{l}.C);
        B = B + ( nl * ( norm(Mu(l, :) - z, 2) ) );

        for i = 1 : nl
            W = W + ( norm(Clusters{l}.C(i, :) - Mu(l, :), 2) );
        end
        
    end
    ind_CH = (B / (k - 1)) / (W / (N - k));
end

