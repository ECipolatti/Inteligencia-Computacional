clear all;
addpath('../../include')
% phi = @(v) (2./(1+exp(-0.8*v)))-1;
phi = @(v) sigmoid(v);

% carga del archivo de datos
fd=csvread('./datos/irisbin.csv');
perm_index=randperm(size(fd,1));
fd = fd(perm_index,:);
% load('partfea.mat');
n_inputs = 4; % cantidad de entradas (definido por el usuario)
n_outputs = size(fd,2) - n_inputs;  % cantidad de salidas (total de columnas
                                    % menos la cantidad de entradas)
% si n_ouputs no es entero mayor o igual a 1 no se puede continuar
if (n_outputs < 1)
    error('Cantidad insuficiente de salidas');
end
                                    
RN = [2 n_outputs]'; % definición de la arquitectura de la red

eta = 0.1;     % tasa de aprendizaje
gamma = 0.2;    % coeficiente de momento
epochs = 100;   % cantidad de épocas
tol = 98;      % tolerancia (porcentaje de acierto mínimo)


% DE ACA PARA ABAJO NO TOCAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
capa_salida=length(RN); %Cantidad de capas de la RN

w = cell(size(RN));  % Pesos de la RN
w0 = cell(size(RN)); % Pesos de la RN (pesos de la iteración anterior)

RN_temp=[n_inputs; RN]; % Agrego la cantidad de entradas al vector
                               % que describe la RN


%% Entrenamiento Leave-k-out
N = length(fd);
K = 1;
M = floor(N/K);

H = zeros(1,M);

for i_k = 1 : M
    [train_data,test_data] = lvkout(fd,K,i_k);
    T = size(train_data,1);
    E = size(test_data,1);
    % Inicializo las matrices de peso (w y w0)
    for i=1:capa_salida
        w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
        w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    end
    
    % Entrenamiento
    hit_perc = 0;
    epoch_counter = epochs;
    while (epoch_counter~=0 && hit_perc < tol)
        % una época de entrenamiento
        [w,w0] = mlp_train(train_data,RN,w,w0,n_inputs,gamma,eta);

        % hacemos verificación con los datos de entrenamiento
        [hit_counter] = mlp_test(train_data,RN,w,n_inputs,n_outputs);

        hit_perc=hit_counter/T*100;
%         fprintf('Porcentaje de acierto %.2f, %d  \n',hit_perc, 1001-epochs);
        epoch_counter = epoch_counter-1;    
    end
    
    % Test
    [hit_counter] = mlp_test(test_data,RN,w,n_inputs,n_outputs);
    H(i_k) = hit_counter/E*100;
    fprintf('Porcentaje de acierto (TEST) %.2f (k: %d)\n',H(i_k),i_k);
end

fprintf('Media: %.2f \n Desv. Std.: %.2f \n',mean(H),std(H));

%% Gráfica (no sirve para irisbin)
if n_inputs < 3
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

    gscatter(y_out(:,1),y_out(:,2),y_out(:,3),'rk','sx');
end
