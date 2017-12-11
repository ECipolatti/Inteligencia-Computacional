function [ ind_I ] = Indice_I( k, Mu )
    Dk = 0;
    for i = 1 : size(Mu, 1)-1
        for j = i+1 : size(Mu, 1)
            aux = norm(Mu(i, :) - Mu(j, :), 2);
            if (aux > Dk)
                Dk = aux;
            end
        end
    end
    
    
    
    ind_I = ( 1/k * (E1/Ek) * Dk );
end
