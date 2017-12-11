function [ seleccionados ] = Competencia( k, Fenotipos, num_ganadores, type_fitnes)
    % VARIABLES
    % k: Rango de seleccion para competencia
    % Genotipos: Cromosomas
    % num_ganadores: total de genoripos seleccionados
    % type_fitnes: tipo de funcion a minimizar
    
    [n, m]= size(Fenotipos);
    seleccionados = zeros(num_ganadores, m);
    
    for i = 1 : num_ganadores
        vec = round(rand(k, 1) * (n-1))+1;
            [g, ~, ~] = Fitnes_Matrix(Fenotipos(vec(:),:),type_fitnes);
            [~,ind] = max(g);
        seleccionados(i, :) = Fenotipos(vec(ind), :);
    end
end

