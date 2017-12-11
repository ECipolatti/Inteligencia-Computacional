function [ Particulas ] = VerificaIntervalos2D( Particulas, a, b )
    [n, m] = size(Particulas);
    for i = 1 : n
        for j = 1 : m
            if Particulas(i, j) < a
                Particulas(i, j) = a;
            elseif Particulas(i, j) > b
                Particulas(i, j) = b;
            end
        end
    end
end

