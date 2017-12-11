function [ ind ] = buscar( P, valor )
    acumulada = cumsum(P);
    acumulada = [0 acumulada];
    ind = 1;
    for i = 1 : length(acumulada) - 1
        if (valor > acumulada(i) && valor < acumulada(i+1))
            ind = i;
        end
    end
end

