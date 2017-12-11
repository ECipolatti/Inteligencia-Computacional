function [M] = prodcorr(A,B)
    % M: matriz de correlación-producto entre A y B
    % A y B conjuntos borrosos
    
    [Ar,Ac] = size(A);
    [Br,Bc] = size(B);
    
    % Si A es una matriz
    if min(Ar,Ac) ~= 1
        error('A debe ser un vector.');
    end
   
    % Si B es una matriz
    if min(Br,Bc) ~= 1
        error('B debe ser un vector.');
    end
    
    % Si el largo de A difiere del largo de B
    if max(Ar,Ac) ~= max(Br,Bc)
        error('A y B deben ser del mismo largo.');
    end

    % Sabiendo que los vectores son del mismo largo, defino una dimensión común a los dos
    N = max(Ar,Ac);
    
    % Matriz de correlación-mínimo -> dimensiones NxN
    M = zeros(N);
    for i = 1 : N
        for j = 1 : N
            M(i,j) = A(i)*B(j);
        end
    end


end

