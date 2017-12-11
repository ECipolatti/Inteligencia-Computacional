function [mu] = graphmemb(M,type,range)
    % M: matriz de parámetros de dimensiones [P,4] para tipo 't' y [P,2] para tipo 'g'
    % type: tipo de función de membresía -> 't': trapecio; 'g' 
    % range: rango de la variable independiente (x)
    
    % control de tipo de función de membresía correcto
    type = lower(type);
    if type ~= 't' && type ~= 'g'
        error('Tipo de función de membresía incorrecto.');
    end
    
    % si no se definió el rango para la gráfica, se toman el rango [min,max]
    if ~exist('range','var')
        range = [min(min(M)),max(max(M))];
    end
    
    [P,C] = size(M);                    % dimensiones de la matriz de parámetros
    x = range(1):0.01:range(2)-0.01;    % vector de x para evaluar membresía y graficar
    mu = zeros(length(x),P);            % matriz de membresía ([largo de x,cant. params]
    
    % si es de tipo trapezoidal
    if type == 't'
        % control de cantidad de parámetros
        if C < 4
            error('Cantidad insuficiente de parámetros para tipo t.');
        end
        
        % para los P conjuntos se llama a membership para el conjunto de datos de x
        for i = 1 : P
            a = M(i,1);
            b = M(i,2);
            c = M(i,3);
            d = M(i,4);
            mu(:,i) = membership([a,b,c,d],type,x);
        end
    
    % si es de tipo gaussiana
    elseif type == 'g'
        % control de cantidad de parámetros
        if C < 2
            error('Cantidad insuficiente de parámetros para tipo g.');
        end
        
        % para los P conjuntos se llama a membership para el conjunto de datos de x
        for i = 1 : P
            m = M(i,1); % media
            s = M(i,2); % desviación standard
            mu(:,i) = membership([m,s],type,x);
        end
    end
    
    % gráficas de los P conjuntos
    plot(x,mu);
    axis([range(1) range(2) 0 1.2005]);
end

