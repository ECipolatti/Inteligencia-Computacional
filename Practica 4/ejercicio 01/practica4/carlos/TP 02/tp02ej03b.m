close all; clear all;
addpath(genpath('../'));

phi = @(z) signo(z);

fd = csvread('concentlite.csv');
% fd = csvread('concentlite.csv');

fd = fd(randperm(size(fd,1)),:);      	% desordeno los datos de entrada
n_inputs = 2;                          % cantidad de entradas

% para corregir si los datos no son +1 y -1
for i = 1 : size(fd,1)
    if fd(i,n_inputs+1:end) == 0
        fd(i,n_inputs+1:end) = -1;
    end
end

n_outputs = size(fd,2)-n_inputs;        % cantidad de salidas
k = 5; %FIJO                           % parámetro k de k-folding
kc = 5;                                % cantidad de centroides
maxep = 1000;                            % cantidad máxima de épocas
epochs = maxep;                         % contador de épocas para el while
tol = 95;                               % porcentaje de acierto mínimo (tolerancia)
hit_perc = zeros(k,1);                  % porcentaje de acierto actual
eta = 0.1;                              % velocidad de aprendizaje

%Estos parametros son para MLP
RN = [kc n_outputs]'; % definición de la arquitectura de la red
gamma = 0.35;        % coeficiente de momento
eta_mlp = eta;

%Inicializo para recolectar datos de analisis
tiempo=zeros(k,1); %Tiempo por conjunto de entrenamiento


[train,test] = kfold(fd,k,1);


P = size(train,1); % Cantidad de patrones de entrenamiento
E = size(test,1);  % Cantidad de patrones de prueba
N = kc;  % Neuronas en la capa de entrada



if n_outputs == 1
        cmp_func = @(y,yd) cmp_signo(y,yd);
    else
        cmp_func = @(y,yd) cmp_winner(y,yd);
end
    

fprintf('Arranca RBF\n');
for i_k = 1 : k
    tic();
    fprintf('Conjunto de datos de entrenamiento %d\n',i_k);
    [train,test] = kfold(fd,k,i_k);
    
    fprintf('Entrenando capa radial...   ');
    %Calculo los centroides
    [index,cent,sigma] = kMeans(train(:,1:n_inputs),kc);
    
    y_rbf = zeros(P,N);
    for i = 1 : P
        for j = 1 : N
            y_rbf(i,j) = exp(-1/2*norm(train(i,1:n_inputs)-cent(j,:)).^2);
        end
    end
    w = rand(n_outputs,N + 1) - 0.5;
    yd = train(:,n_inputs+1:end);
    y=0*yd;
    x = [-ones(P,1) y_rbf];
    fprintf('Entrenando perceptron ...   ');
    while (epochs > 0 && hit_perc(i_k) < tol)
        for i = 1 : P
            e = phi(x(i,:)*w') - yd(i,:);
            w = w - eta*e'*x(i,:);
        end

        v=x*w';
        hit_counter = 0;
        for i = 1 : P
            y(i,:) = phi(v(i,:));
            hit_counter = hit_counter + (equal(y(i,:),yd(i,:)));
        end
        hit_perc(i_k) = hit_counter/P*100;
        if (hit_perc(i_k) > tol)
            fprintf('[Epoca=%d]',maxep-epochs);
        end
        epochs = epochs - 1;
    end
    if (hit_perc(i_k) < tol)
        fprintf('[Max. Epoca]');
    end

    tiempo(i_k)=toc();
    fprintf('Tiempo: %.2f   ',tiempo(i_k));
    fprintf('Porc. de acierto (train): %.2f\n',hit_perc(i_k));
    
    epochs = maxep;
    % Termino el entrenamiento
    
    % Pruebo la red con el conjunto de test
    % Propago test
    y_rbf = zeros(E,N);
    for i = 1 : E
        for j = 1 : N
            y_rbf(i,j) = exp(-1/2*norm(test(i,1:n_inputs)-cent(j,:)).^2);
        end
    end
    
    yd = test(:,n_inputs+1:end);
    y=0*yd;
    x = [-ones(E,1) y_rbf]; %Entrada a la capa de salida (perceptron)
    hit_counter = 0;
    for i = 1 : E %Paso las salidas de la capa radial por el perceptron
        y(i,:)= phi(x(i,:)*w'); %Esta w es la del perceptron
        hit_counter = hit_counter + (equal(y(i,:),yd(i,:)));
    end
    hit_perc(i_k) = hit_counter/E*100;
    
    %Ploteo RBF si estoy trabajando en 2D
    if (n_inputs == 2)
        figure;
        X = test(:,1:2);
        Y = y;
        for i = 1 : E
            if Y(i) ~= yd(i)
                Y(i) = 2;
            end
        end

        gscatter(X(:,1),X(:,2),Y,'kgr','..x');
        hold on;
        scatter(cent(:,1),cent(:,2),500);
    end
end



rbf_tiempo_medio=mean(tiempo);
rbf_porc_medio=mean(hit_perc);

fprintf('[RBF] kc=%d centroides.  Tiempo medio : %.2f   Porc. medio de aciertos (test): %.2f\n',kc,rbf_tiempo_medio,rbf_porc_medio);

%% ACA ARRANCA MLP

fprintf('Arranca MLP\n');
phi = @(v) sigmoid(v);
hit_perc = zeros(k,1);
y=cell(size(RN));

for i_k=1:k
    tic();
    fprintf('Conjunto de datos de entrenamiento %d\n',i_k);

    epochs = maxep;

    % DE ACA PARA ABAJO NO TOCAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    capa_salida=length(RN); %Cantidad de capas de la RN

    w = cell(size(RN));  % Pesos de la RN
    w0 = cell(size(RN)); % Pesos de la RN (pesos de la iteración anterior)
    momento = cell(size(RN));

    RN_temp=[n_inputs; RN]; % Agrego la cantidad de entradas al vector
                            % que describe la RN
    H = zeros(1,maxep); % Evolucion del porc de acierto

    % Inicializo random                         
    for i=1:capa_salida
        w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
        w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
        momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    end

    [train, test] =  kfold(fd,k,i_k);

    fprintf('Entrenando MLP...   ');

    while (epochs~=0 && hit_perc(i_k) < tol)
        % una época de entrenamiento
        [w,w0] = mlp_train(train,RN,w,w0,n_inputs,gamma,eta_mlp);

        % verificación con los datos de entrenamiento
        [hit_counter] = mlp_test(train,RN,w,n_inputs,n_outputs);

        hit_perc(i_k) = hit_counter/P*100;
%         fprintf('Porcentaje de acierto %.2f - Epoca %d\n',hit_perc(i_k),maxep-epochs);
        if (hit_perc(i_k) > tol)
            fprintf('[Epoca=%d]',maxep-epochs);
        end
        epochs=epochs-1;

        % historico de error para gráfica
        H(maxep-epochs+1) = hit_perc(i_k);
    end
    tiempo(i_k)=toc();
    if (hit_perc(i_k) < tol)
        fprintf('[Max. Epoca]');
    end
    fprintf('Tiempo: %.2f   ',tiempo(i_k));
    fprintf('Porc. de acierto (train): %.2f\n',hit_perc(i_k));
    
  	[hit_counter] = mlp_test(test,RN,w,n_inputs,n_outputs);
   
    hit_perc(i_k) = hit_counter/E*100;
    %fprintf('Porcentaje de acierto (TEST) %.2f \n',hit_perc);
    
    epochs=epochs-1;

    %Ploteo MLP si estoy trabajando en 2D
    if (n_inputs == 2)
        figure;

        x = [-ones(E,1)  test(:,1:n_inputs)];
        yd = test(:,n_inputs+1:end);
        if size(yd,2)~=1
            error('Mas de una salida');
        end

        %% Propagacion hacia adelante
        y{1}=phi(w{1}*x');

        for i=2:capa_salida
            y{i}=phi(w{i}*[-ones(E,1)'; y{i-1}]);
        end
        
        X = test(:,1:2);
        Y = signo(y{capa_salida});
        for i = 1 : E
            if Y(i) ~= yd(i)
                Y(i) = 2;
            end
        end

        gscatter(X(:,1),X(:,2),Y,'kgr','..x');
    end
end

mlp_tiempo_medio=mean(tiempo);
mlp_porc_medio=mean(hit_perc);
fprintf('[MLP] Arquitectura: [%d %d].  Tiempo medio : %.2f   Porc. medio de aciertos (test): %.2f\n',RN(1),n_outputs,mlp_tiempo_medio,mlp_porc_medio);

fprintf('======================== Resumen ========================\n');
fprintf('[RBF] kc=%d centroides.  Tiempo medio : %.2f   Porc. medio de aciertos (test): %.2f\n',kc,rbf_tiempo_medio,rbf_porc_medio);
fprintf('[MLP] Arquitectura: [%d %d].  Tiempo medio : %.2f   Porc. medio de aciertos (test): %.2f\n',RN(1),n_outputs,mlp_tiempo_medio,mlp_porc_medio);

%% Arranca SOM
fprintf('Arranca MLP\n');