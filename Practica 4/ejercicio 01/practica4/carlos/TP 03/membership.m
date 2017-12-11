function [mu] = membership(params,type,x)
    % params: vector de parámetros que definen la forma de la función de membresía
    % type: tipo de función de membresía -> 't': trapecio; 'g' 
    % x: valor para  el que se calcula la membresía al conjunto dado por params
    % mu: valor calculado de membresía
    
    type = lower(type);
    if type ~= 't' && type ~= 'g'
        error('Tipo de función de membresía incorrecto.');
    end
    
    % verifico que no sea una matriz y en caso de ser vector me aseguro que en N tenga el
    % largo del vector
    [M,N] = size(x);
    if N > 1 && M > 1
        error('x debe ser un vector.');
    elseif M > N
        N = M;
    end
    mu = zeros(1,N);
    % para tipo trapezoidal
    if type == 't'
        if length(params) < 4
            error('Cantidad insuficiente de parámetros para tipo t.');
        end
        a = params(1);
        b = params(2);
        c = params(3);
        d = params(4);
        
        for i = 1 : N
            if x(i) < a
                mu(i) = 0;
            elseif x(i) < b
                mu(i) = (x(i)-a)/(b-a);
            elseif x(i) <= c
                mu(i) = 1;
            elseif x(i) <= d
                mu(i) = 1 - (x(i)-c)/(d-c);
            else
                mu(i) = 0;
            end
            
       end
    % para tipo gaussiana    
    elseif type == 'g'
        if length(params) < 2
            error('Cantidad insuficiente de parámetros para tipo g.');
        end
        m = params(1);  % media
        s = params(2);  % desviación standard
        for i = 1 : N
            mu(i) = exp(-(1/2)*((x(i)-m)/s)^2);
        end
    end
end

