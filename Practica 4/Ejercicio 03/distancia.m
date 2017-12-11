function [ dist ] = distancia( pk, D )
    dist = 0;
    for i =1 : length(pk) - 1
        nodo_inicial = pk(i);
        nodo_final = pk(i+1);
        dist = dist + D(nodo_inicial, nodo_final);
    end
end

