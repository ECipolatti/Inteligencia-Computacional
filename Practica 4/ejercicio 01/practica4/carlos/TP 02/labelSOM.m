function [E] = labelSOM(W,data,n_inputs)
    % W: pesos de la Red Neuronal
    % data: matriz de datos (incluye entradas y salidas)
    % n_inputs: cantidad de entradas
    [H,L] = size(W);                        % cantidad de neuronas de la RN
    P = size(data,1);                       % cantidad de patrones en la matriz de datos
    for i = 1 : H
        for j = 1 : L
            dist = zeros(1,P);
            for k = 1 : P
                pattern = data(k,1:n_inputs);
                dist(k) = norm(pattern - W{i,j});
            end
            [~,winner] = min(dist);
            E{i,j} = data(winner,n_inputs+1:end);
        end
    end
end
