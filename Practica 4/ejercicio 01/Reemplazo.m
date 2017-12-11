function [ Nueva_Poblacion ] = Reemplazo(Elite, Hijos, Mutados, num_hijos, num_mutados, num_poblacion)
    n = num_poblacion;
    m = size(Hijos,2);
    Nueva_Poblacion = zeros(n,m);
    % Elite
    Nueva_Poblacion(1,:) = Elite(:,:);
    
    % Hijos
    Nueva_Poblacion(2:num_hijos+1,:) = Hijos(:,:);
    
    % Mutados
    Nueva_Poblacion(num_hijos+2:end,:) = Mutados(1:num_mutados,:);


end

