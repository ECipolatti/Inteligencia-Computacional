function [ muA ] = membership( tipomembership, M, x )
    % Usando trapecios
    if (tipomembership == 'T')
        if (x < M(1) || (x > M(4)))
            muA = 0;
        elseif (x >= M(1) && x < M(2))
            muA = (x - M(1)) / (M(2) - M(1));
        elseif (x >= M(2) && x <= M(3))
            muA = 1;
        elseif (x > M(3) && x <= M(4))
            muA = 1 - (x - M(3)) / (M(4) - M(3));
        end
    else
        % Usando Gaussianos
        muA = exp(-.5 * ((x - M(1))/M(2))^2);
    end
end

