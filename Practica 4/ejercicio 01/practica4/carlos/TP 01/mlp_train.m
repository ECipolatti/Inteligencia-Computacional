function [ w,w0 ] = mlp_train(train_data,RN,w,w0,n_inputs,gamma,eta)
    phi = @(v) sigmoid(v);
    
    T = length(train_data); %Cantidad de ejemplos de entrenamiento
    capa_salida=length(RN); %Cantidad de capas de la RN
    
    % Inicializo momento
    momento = cell(size(RN));
    RN_temp=[n_inputs; RN]; % Agrego la cantidad de entradas al vector
                            % que describe la RN
    for i=1:capa_salida
        momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    end
    
    for i_d = 1 : T %Por cada ejemplo del conjunto de entrenamiento corrijo pesos
        %Agrego el x0 al vector
        x=train_data(i_d,1:n_inputs)';
        yd=train_data(i_d,(n_inputs+1):end);

        y=cell(size(RN)); % Salidas de cada capa

        %% Propagacion hacia adelante
        y{1}=phi(w{1}*[-1; x]);
        for i=2:capa_salida
            y{i}=phi(w{i}*[-1; y{i-1}]);
        end

        %% Retropropagacion
        % Genero una matriz de deltas para la retropropagacion
        geli = cell(size(RN)); %GELI = Gradiente de Error Local Instantaneo
        % y otra matriz para los Delta w
        dw = cell(size(RN));
      
        err = yd'-y{capa_salida};
        
        %Caso especial de la capa de salida
        geli{capa_salida}= .5 * err .* ((1+y{capa_salida}) .* (1-y{capa_salida}));

        for i=capa_salida-1:-1:1 % Retropropago desde la primer capa oculta hasta la capa de entrada
            geli{i} = (w{i+1}(:,2:end)' * geli{i+1}).* (0.5 * ((1+y{i}) .* (1-y{i})));
        end

        %% Actualizo los pesos de la RN
        % primero empiezo por el t??rmino de momento
        for i = 1 : capa_salida
            momento{i} = gamma*(w{i}-w0{i});
        end
        % actualizo los pesos de la iteración anterior
        w0 = w;
        
        dw{1} = eta*geli{1}*([-1;x])';
        w{1} = w{1} + dw{1} + momento{1};
        for i=2:capa_salida
            dw{i} = eta*geli{i}*([-1;y{i-1}])';
            w{i} = w{i} + dw{i} + momento{i};
        end
    end
end