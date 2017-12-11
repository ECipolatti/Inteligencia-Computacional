function [W] = weightSOM(RN,n_inputs,X)
    % H: cantidad vertical de neuronas (Height)
    % L: cantidad horizontal de neuronas (Length)
    % n_inputs: cantidad de entradas (dimensiones de cada neurona)
    % X: vector de datos -> si está inicializado es modo 1-, sino es modo 2-
    %       [1- pesos aleatorios entre -0.5 y 0.5]
    %       [2- pesos tomados de H*L patrones de entrada aleatorios]
    H = RN(1);
    L = RN(2);
    W = cell(H,L);
    if ~exist('X','var')
        for i = 1 : H
            for j = 1 : L
                W{i,j} = rand(1,n_inputs) - .5;
            end
        end
    else
        index = randperm(size(X,1),H*L);
        k = 0;
        for i = 1 : H
            for j = 1 : L
                k = k+1;
                W{i,j} = X(index(k),:);
            end
        end
    end
end

