function [S] = selection(P,prate,k,fitness,method)
    % selección natural
    % P:        población -> M individuos x N genes
    % prate:    tasa de padres a seleccionar
    % k:        cantidad de padres a elegir
    % fitness:  aptitud de los M individuos
    % method:   método de selección: 
    %               1: ventanas
    %               2: competencia
    %               3: ruleta
    % S:        padre elegidos
    
    switch method 
        case 1                                  % VENTANAS
            S = windows(P,prate,fitness);
        case 2                                  % COMPETENCIA
            S = competition(P,prate,k,fitness);
        case 3                                  % RULETA
            S = roulette(P,prate,fitness);
        otherwise                               % en cualquier otro caso VENTANAS
            S = windows(P,k,fitness);
    end
end

