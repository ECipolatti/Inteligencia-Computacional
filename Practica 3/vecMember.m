function [ muA ] = vecMember( tipo, M, X_i )
    [n, ~] = size(M);
    muA = zeros(1,n);
    for i = 1 : n
        muA(i) = membership(tipo, M(i,:), X_i);
    end
end

