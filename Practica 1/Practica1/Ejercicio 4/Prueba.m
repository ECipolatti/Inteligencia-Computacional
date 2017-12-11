function [Er] = Prueba(Data,capa, num_salidas, num_entradas, vec_num_neu)
    
    [n, ~] = size(Data);
    X = [-ones(n,1) Data(:, 1:num_entradas)];           % Matriz X extendida
    Yd = Data(:, num_entradas+1:end);                   % MAtriz Yd, salidas deseadas
    Y = zeros(n,num_salidas);                           % Salida
    num_capas = length(vec_num_neu);                    % Num de capas
    
    Er = 0;
 for p=1 : n % p recorre por patron

        % Propagacion hacia Adelante
        capa{1}.Y = capa{1}.W * X(p, :)';
        capa{1}.Y = sigmoid(capa{1}.Y);

        for c = 2 : num_capas     % c es indices de capas 
            capa{c}.Y = capa{c}.W * [-1; capa{c-1}.Y];
            capa{c}.Y = sigmoid(capa{c}.Y);
        end

        Y(p,:) = capa{num_capas}.Y;

        if isequal(descodificar(Y(p,:)),Yd(p,:)) == 0 
           Er = Er + 1;
        end
  end
  Er = (Er*100)/n;
end

