clear all; close all;
addpath('../../include')

phi = @(v) sigmoid(v);

fd = csvread('../include/tp01data/concentlite.csv');

n_inputs = 2; % cantidad de entradas (definido por el usuario)
n_outputs = size(fd,2) - n_inputs;  % cantidad de salidas (total de columnas
                                    % menos la cantidad de entradas)
% si n_ouputs no es entero mayor o igual a 1 no se puede continuar
if (n_outputs < 1)
    error('Cantidad insuficiente de salidas');
end
                                    
RN = [6 n_outputs]'; % definición de la arquitectura de la red

eta = 0.1;          % tasa de aprendizaje
gamma = 0.1;        % coeficiente de momento
max_ep = 1000;      % cantidad máxima de épocas
epochs = max_ep;	% contador de épocas para el while
tol = 95;
hit_perc = 0;

% DE ACA PARA ABAJO NO TOCAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
capa_salida=length(RN); %Cantidad de capas de la RN

w = cell(size(RN));  % Pesos de la RN
w0 = cell(size(RN)); % Pesos de la RN (pesos de la iteración anterior)
momento = cell(size(RN));

RN_temp=[n_inputs; RN]; % Agrego la cantidad de entradas al vector
                        % que describe la RN
H = zeros(1,max_ep);

% Inicializo random                         
for i=1:capa_salida
    w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
    w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
end

[train_data, test_data] = cross_validation_partition(fd,.8);
T = size(train_data,1); % Cantidad de patrones de entrenamiento
E = size(test_data,1);  % Cantidad de patrones de prueba
while (epochs~=0 && hit_perc < tol)
    % una época de entrenamiento
    [w,w0] = mlp_train(train_data,RN,w,w0,n_inputs,gamma,eta);

    % verificación con los datos de entrenamiento
    [hit_counter] = mlp_test(train_data,RN,w,n_inputs,n_outputs);
       
    hit_perc = hit_counter/T*100;
    fprintf('Porcentaje de acierto %.2f, Epoca %d  \n',hit_perc, max_ep-epochs+1);
    epochs=epochs-1;
    
    % historico de error para gráfica
    H(max_ep-epochs+1) = hit_perc;
end

y_out = zeros(size(test_data,1),3);
hit_counter = 0;
for i_e = 1 : E
    x = [-1; test_data(i_e,1:n_inputs)'];
    yd = fd(i_e,end);

    %% Propagacion hacia adelante
    y{1}=phi(w{1}*x);

    for i=2:capa_salida
        y{i}=phi(w{i}*[-1;y{i-1}]);
    end

    aux = signo(y{capa_salida});
    if(aux ~= test_data(i_e,end))
        y_out(i_e,:) = [x(2),x(3),0];
    else
        y_out(i_e,:) = [x(2),x(3),aux];
        hit_counter=hit_counter+1;
    end
end

hit_perc = hit_counter/E*100;
fprintf('Porcentaje de acierto (TEST) %.2f \n',hit_perc);
epochs=epochs-1;

gscatter(y_out(:,1),y_out(:,2),y_out(:,3),'grk','o*o');

figure;
plot(H(1:(max_ep-epochs)));
xlabel('Epocas');
ylabel('Porcentaje de acierto');
