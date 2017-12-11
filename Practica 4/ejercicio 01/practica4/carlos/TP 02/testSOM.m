function [hit_perc] = testSOM(W,E,data,n_inputs)
    % W: pesos de la Red Neuronal (SOM)
    % E: etiquetas asociadas a los pesos W
    % data: datos de prueba
    % n_inputs: cantidad de entradas
    
    P = size(data,1);       % cantidad de patrones    
    hit_counter = 0;
    X = data;
    for i = 1 : P
        pattern = data(i,:);
        [wrow,wcol] = findWinner(W,pattern(1:n_inputs),n_inputs);
        hit = E{wrow,wcol} == pattern(n_inputs+1:end);
        if hit
            hit_counter = hit_counter + 1;
            X(i,n_inputs+1:end) = pattern(n_inputs+1:end);
        else
            X(i,n_inputs+1:end) = 2;
        end
        
    end
    hit_perc = hit_counter/P*100;
    fprintf('Porcentaje de acierto (TEST): %.2f\n',hit_perc);
    
    % gráfica (sólo para los casos de entradas 2-D)
    if n_inputs == 2
        figure;
        gscatter(X(:,1),X(:,2),X(:,3), 'gbr', '..x');
    end    
end

