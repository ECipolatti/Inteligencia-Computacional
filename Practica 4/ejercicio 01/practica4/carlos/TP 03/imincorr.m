function [B] = imincorr(A,M)
    % correlación-mínimo inversa (entre un vector y una matriz)
    
    [Ar,Ac] = size(A);  % cantidad de filas y columnas de A
    [Mr,Mc] = size(M);  % cantidad de filas y columnas de A
    
    if Mr ~= Mc
        error('M debe ser una matriz cuadrada.');
    end
    
    if min(Ar,Ac) ~= 1
        error('A debe ser un vector.');
    end
    
    if Mr ~= max(Ar,Ac)
        error('A y M deben coincidir en una dimensión.');
    end
    
    N = Mr;
    
    % B tendrá dimensiones transpuestas a las de A: si A es fila B es columna y viceversa
    B = zeros(Ac,Ar);

    % Si a es un vector fila hay que transponer M y A para que la operación quede bien
    % definida
    if Ar < Ac
        M = M.';
        A = A.';
    end
    
    % regla nemotécnica i: máximo del mínimo
    for i = 1 : N
        B(i) = max(min(A,M(:,i)));
    end

end
