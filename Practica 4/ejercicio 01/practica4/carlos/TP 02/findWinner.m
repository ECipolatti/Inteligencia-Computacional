function [row,col] = findWinner(W,pattern,n_inputs)
    [H,L] = size(W);                            % dimensiones de la red neuronal
    M = cell2mat(W);                            % creo una matriz a partir del cell W
    A = [];                                     % en A voy armando una matriz con H*L filas y
    for i = 1 : n_inputs : size(M,2)-n_inputs+1 % tantas columnas como entradas tenga la RN (n_inputs)
        A = [A ; M(:,i:i+n_inputs-1)];
    end

    index = zeros(H*L,2);                       % en index guardo la correlación de la matriz A con W
    k = 0;
    for i = 1 : L
        for j = 1 : H
            k = k+1;
            index(k,:) = [j i];
        end
    end
    
    dist = zeros(L*H,1);                        % calculo la distancia del patrón de entrada a todas
                                                % las neuronas
    for i = 1 : H*L
        dist(i) = norm(pattern - A(i,:));
    end

    [~,m] = min(dist);                          % hallo la mínima distancia y devuelvo el valor de fila
    row = index(m,1);                           % y columna al que pertenece en la RN
    col = index(m,2);

end

