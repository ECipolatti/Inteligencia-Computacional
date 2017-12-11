function [ Clusters ] = Clusteres( k, Data, Indices )
    for i = 1 : k
        aux = Data( Indices(:) == i, : );
        Clusters{i}.C = aux;
    end
end

