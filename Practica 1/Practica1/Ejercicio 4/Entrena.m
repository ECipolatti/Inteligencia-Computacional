function [capa,Er,Ep] = Entrena (Data, LearnRt, MomRt, MaxEp, TolEr, num_salidas, num_entradas, vec_num_neu)
    
    [n m] = size(Data);
    vec_error = zeros(MaxEp, 1);
    X = [-ones(n,1) Data(:, 1:num_entradas)];           % Matriz X extendida
    Yd = Data(:, num_entradas+1:end);                   % MAtriz Yd, salidas deseadas
    Y = zeros(n,num_salidas);                           % Salida
    num_capas = length(vec_num_neu);                    % Num de capas
    
    capa{1}.W = rand(vec_num_neu(1), length(X(1,:)))-0.5;
    capa{1}.DW = zeros(vec_num_neu(1), length(X(1,:)));
    capa{1}.Y = zeros(vec_num_neu(1), 1);
    capa{1}.D = zeros(vec_num_neu(1), 1);
    for i=2 : num_capas
        capa{i}.W = rand(vec_num_neu(i), vec_num_neu(i-1)+1) - 0.5;
        capa{i}.DW = zeros(vec_num_neu(i), vec_num_neu(i-1)+1);
        capa{i}.Y = zeros(vec_num_neu(i), 1);
        capa{i}.D = zeros(vec_num_neu(i), 1);
    end

    Ep = 1;
    Er = 100;
    while (Ep < MaxEp) && (TolEr < Er)
        % Calculando los mejores W
        for p=1 : n % p recorre por patron

            % Propagacion hacia Adelante
            capa{1}.Y = capa{1}.W * X(p, :)';
            capa{1}.Y = sigmoid(capa{1}.Y);

            for c = 2 : num_capas     % c es indices de capas 
                capa{c}.Y = capa{c}.W * [-1; capa{c-1}.Y];
                capa{c}.Y = sigmoid(capa{c}.Y);
            end

            % Propagacion - deltas
            error = Yd(p,:)' - capa{num_capas}.Y;
            %Calculo los Deltas
            capa{num_capas}.D = 0.5 .* error .* (1+capa{num_capas}.Y) .* (1-capa{num_capas}.Y);  % delta en la ultima capa
            for k=(num_capas-1): -1 : 1
                 capa{k}.D = (capa{k+1}.W(:,2:end)' * capa{k+1}.D) .* 0.5 .* (1+capa{k}.Y) .* (1-capa{k}.Y);
            end

            % Actualizo los pesos
            %capa{1}.W = capa{1}.W + LearnRt * capa{1}.D * X(p,:); 
            capa{1}.DW = LearnRt * capa{1}.D * X(p,:) + MomRt * capa{1}.DW; % guardo DW 
            capa{1}.W = capa{1}.W + capa{1}.DW; % actualizo con momento
            
            for c=2 : num_capas
               %capa{c}.W = capa{c}.W + (LearnRt * capa{c}.D * [-1; capa{c-1}.Y]');
               capa{c}.DW = (LearnRt * capa{c}.D * [-1; capa{c-1}.Y]') + MomRt * capa{c}.DW; % guardo DW
               capa{c}.W = capa{c}.W + capa{c}.DW; % actualizo con momento
               
            end
        end  % end for - ACA TERMINA LA EPOCA DEJANDO EL MEJOR W PARA CADA CAPA 

    %     % Calculo porcentaje error
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
        vec_error(Ep) = Er;
        % Incremento las Epocas
        Ep=Ep+1; 
    end


end

