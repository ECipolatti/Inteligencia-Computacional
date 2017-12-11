function [ ind ] = buscar( acumulada, valor )
    ind = 1;
    for i = 1 : length(acumulada) - 1
        if (valor > acumulada(i) && valor < acumulada(i+1))
            ind = ind + 1;
        end
    end
end

