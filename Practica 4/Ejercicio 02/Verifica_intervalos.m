    function [ Particulas ] = Verifica_intervalos( Particulas, a, b)

    [n, ~] = size(Particulas);
    for i = 1:n
        if Particulas(i) < a
            Particulas(i) = a;
        end
        if Particulas(i) > b
            Particulas(i) = b;
        end
    end
end

