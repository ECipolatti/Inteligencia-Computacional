function [S] = roulette(P,prate,fitness)
    % selección por método de Ruleta
    % P:        población actual
    % prate:    tasa de progenitores a seleccionar
    % fitness:  fitness de cada individuo de la población
    
    [M,N] = size(P);                        % M individuos con N genes c/u
    R = round(prate*M);                     % cantidad de progenitores seleccionados
    fitness = fitness - min(fitness);       % hago positivos todos los valores del fitness
    sumf = sum(fitness);                    % total de fitness
    prob = fitness/sumf;                    % probabilidad de ser elegido en relación al fitness
    prob = [0;prob];                        % agrego el cero
    prob = cumsum(prob);                    % suma acumulativa de probabilidades
    % lo anterior se entiende como:
    % segmento [prob(1),prob(2))   -> corresponde al índice 1 (semiabierto a la derecha)
    % segmento [prob(2),prob(3))   -> corresponde al índice 2
    % .......................................................
    % segmento [prob(M),prob(M+1)) -> corresponde al índice M
    % luego al sumar todas las probabilidades mayores a un número cualquiera entre 0 y 1
    % se obtiene el índice (suma de suma acumulativa de probabilidades). entonces cuando
    % la suma de da cero es el índice 1 y cuando da 1 es el índice M
    S = zeros(R,N);
    for i = 1 : R
        p = rand;                           % número al azar entre 0 y 1
        q = sum(p >= prob);                 % índice del valor cuya probabilidad salió
        S(i,:) = P(q,:);
    end    
end
