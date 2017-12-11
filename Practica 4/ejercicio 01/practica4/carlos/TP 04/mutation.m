function [S] = mutation(S,mrate)
    % mutación de los 'S' cromosomas con tasa 'rate'
    % S:    cromosomas. matriz de MxN bits
    % rate: tasa de mutación (entre 0.0 y 1.0). estrategia elegida cantidad de genes mutados
    [M,N] = size(S);        % M cromosomas de N genes cada uno
    Q = round(M*N*mrate);   % Q es la cantidad total de genes a mutar
    k = 1;                  % contador de mutaciones
    row = randperm(M);      % vector de M valores aleatorios entre 1 y M
    col = randperm(N);      % vector de N valores aleatorios entre 1 y N
    
    % se recorre la matriz entera y se van tomando filas y columnas al azar (row,col)
    % si el número de mutaciones es mayor a Q se sale del algoritmo
    for i = 1 : M
        for j = 1 : N
            if k <= Q
                S(row(i),col(j)) = mod(S(row(i),col(j))+1,2);   % cambia 1 por 0 y 0 por 1
                k = k+1;    % incrementa el contador de mutaciones
            else
                return;     % si k > Q sale
            end
        end
    end
    
end
