function [mu] = membvec(M,type,x)
    % M: matriz con la definición de P conjuntos difusos
    % x: valor de entrada
    % mu: vector con los niveles de membresía para cada uno de los P conjuntos
    
    % Cantidad de conjuntos
    P = size(M,1);
    
    % control de tipo de función de membresía correcto
    type = lower(type);
    if type ~= 't' && type ~= 'g'
        error('Tipo de función de membresía incorrecto.');
    end

    mu = zeros(P,1);
    % Si la matriz tiene conjuntos con membresía de tipo trapezoidal/triangular
    if type == 't'
        % para los P conjuntos se llama a membership de x
        for i = 1 : P
            a = M(i,1);
            b = M(i,2);
            c = M(i,3);
            d = M(i,4);
            mu(i) = membership([a,b,c,d],type,x);
        end
    end
    
    % Si la matriz tiene conjuntos con membresía de tipo Gaussiana
    if type == 'g'        
        % para los P conjuntos se llama a membership de x
        for i = 1 : P
            m = M(i,1); % media
            s = M(i,2); % desviación standard
            mu(i) = membership([m,s],type,x);
        end
    end
end

