function [B] = iprodcorr(A,M)
% correlación-mínimo entre un vector y una matriz
    
    [Ar,Ac] = size(A);
    [Mr,Mc] = size(M);
    
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
    
    B = zeros(Ac,Ar);
    for i = 1 : N
        if Ar > Ac  % si A es un vector columna
            B(i) = max(A.*M(:,i));
        else        % si A es un vector fila
            B(i) = max(A.*M(i,:));
        end
    end


end

