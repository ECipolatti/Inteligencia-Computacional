function [ muA ] = matrixMember( tipo, M, X )
    [n, m] = size(M);
    o = length(X);
    muA = zeros(o, n);
    if (tipo == 'T')
        for i = 1 : o   % Recorro los valores de la Variable
            for j = 1 : n;
                if (X(i) < M(j, 1) || (X(i) > M(j, 4)))
                    muA(i, j) = 0;
                elseif (X(i) >= M(j, 1) && X(i) < M(j, 2))
                    muA(i, j) = (X(i) - M(j, 1)) / ( M(j, 2) - M(j, 1));
                elseif (X(i) >= M(j, 2) && X(i) <= M(j, 3))
                    muA(i, j) = 1;
                elseif (X(i) > M(j, 3) && X(i) <= M(j, 4))
                    muA(i, j) = 1 - (X(i) - M(j, 3)) / (M(j, 4) - M(j, 3));
                end
            end
        end
    else    % Usando Gaussianos
        for i = 1 : o
            for j = 1 : n
            muA(i, j) = exp(-.5 * ((X(i) - M(j, 1))/ M(j, 2))^2);
            end
        end
    end
end

