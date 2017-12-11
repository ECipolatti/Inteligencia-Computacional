function [fitness,best,m] = evalFitness(x,f)
    % cálculo de fitness, solo se aplica la función y se devuelve el máximo:
    % x:        dimensión de entrada
    % f:        función de fitness (puntero a función)
    if(size(x,2) == 1)                  % CASO 1D
        fitness = f(x);                 % se evalúa el fitness
        [best,m] = max(fitness);        % se guarda el valor y la posición del mejor
    elseif(size(x,2) == 2)              % CASO 2D
        fitness = f(x(:,1),x(:,2));     % se evalúa el fitness
        [best,m] = max(fitness);        % se guarda el valor y la posición del mejor
    end
end