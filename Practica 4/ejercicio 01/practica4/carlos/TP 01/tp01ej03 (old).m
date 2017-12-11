clear all;
addpath('../../include')
% phi = @(v) (2./(1+exp(-0.8*v)))-1;
phi = @(v) sigmoid(v);

RN=[4 8 1]';
n_inputs=2;

eta = 0.05;     % tasa de aprendizaje
gamma = 0;    % coeficiente de momento
epochs = 1000;
tol = 0.001;
tol_error = .05;
error_perc = 1;

fd=csvread('./datos/concentlite.csv');

% DE ACA PARA ABAJO NO TOCAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
capa_salida=length(RN); %Cantidad de capas de la RN

w = cell(size(RN));  % Pesos de la RN
w0 = cell(size(RN)); % Pesos de la RN (pesos de la iteraci??n anterior)
momento = cell(size(RN));

RN_temp=[n_inputs; RN]; % Agrego la cantidad de entradas al vector
                               % que describe la RN

% Inicializo random                         
for i=1:capa_salida
    w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
    w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
end

% train_data=fd;
% test_data=fd;
    [train_data, test_data] = cross_validation_partition(fd,.8);
    T=length(train_data); %Cantidad de ejemplos de entrenamiento
while (epochs~=0 && error_perc > tol_error)

    sumE=0;
    for i_d=1:T %Por cada ejemplo del conjunto de entrenamiento corrijo pesos

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
      
        error=yd-y{capa_salida};
        
        %Caso especial de la capa de salida
        geli{capa_salida}= .5 * error .* ((1+y{capa_salida}) .* (1-y{capa_salida}));

        for i=capa_salida-1:-1:1 % Retropropago desde la primer capa oculta hasta la capa de entrada
            geli{i} = (w{i+1}(:,2:end)' * geli{i+1}).* (0.5 * ((1+y{i}) .* (1-y{i})));
        end

        %% Actualizo los pesos de la RN
        % primero empiezo por el t??rmino de momento
        for i = 1 : capa_salida
            momento{i} = gamma*(w{i}-w0{i});
        end
        
        dw{1} = eta*geli{1}*([-1;x])';
        w{1} = w{1} + dw{1} + momento{1};
        for i=2:capa_salida
            dw{i} = eta*geli{i}*([-1;y{i-1}])';
            w{i} = w{i} + dw{i} + momento{i};
        end
        
        % actualizo los pesos de la iteración anterior
        w0 = w;
    end

    error_counter = 0;

    E=length(test_data); %Cantidad de ejemplos para test

    for i_e=1:E

        x = [-1; test_data(i_e,1:n_inputs)'];
        yd = test_data(i_e,end);
        
        %% Propagacion hacia adelante
        y{1}=phi(w{1}*x);

        for i=2:capa_salida
            y{i}=phi(w{i}*[-1;y{i-1}]);
        end
               
        if (sign(y{capa_salida})~=yd)
            error_counter=error_counter+1;
        end
    end
       
    error_perc=error_counter/E;
    fprintf('Porcentaje de error %.4f, %d  \n',error_perc, 1001-epochs);
    epochs=epochs-1;    
end

%% Gráfica
y_out = zeros(length(fd),3);
for i_e = 1 : length(fd)
    x = [-1; fd(i_e,1:n_inputs)'];
    yd = fd(i_e,end);

    %% Propagacion hacia adelante
    y{1}=phi(w{1}*x);

    for i=2:capa_salida
        y{i}=phi(w{i}*[-1;y{i-1}]);
    end

    y_out(i_e,:) = [x(2),x(3),signo(y{capa_salida})];
end

gscatter(y_out(:,1),y_out(:,2),y_out(:,3),'rk','sx')
