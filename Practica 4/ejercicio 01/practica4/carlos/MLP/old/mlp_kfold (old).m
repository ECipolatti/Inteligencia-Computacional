function [A,time] = mlp_kfold(train_data,test_data,RN,n_in,n_out,tol)
tic;
fprintf('RN = [ %d %d %d ]\n',RN(1),RN(2),RN(3));
phi = @(v,c) sigmoid(v,c);
c = 0.1;              % parámetro de la sigmoidea <-- REVISAR!!



eta = 0.05;                 % tasa de aprendizaje
gamma = 0.1;                % coeficiente de momento
max_ep = 500;               % cantidad máxima de épocas

k = 3;                      % cantidad total de particiones para k-fold
wk = cell([k size(RN)]);	% Pesos de la RN para cada partición de k-folding
trnpk = zeros(1,k);         % porcentaje de acierto de entrenamiento para cada partición
valpk = zeros(1,k);         % porcentaje de acierto de validación para cada partición
nepk = zeros(1,k);          % cantidad de épocas de entrenamiento para cada partición
% DE ACA PARA ABAJO NO TOCAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Comienzo del entrenamiento...\n');
parfor i_k = 1 : k
    epochs = max_ep;	   % contador de épocas para el while
    hit_perc = 0;          % inicializo el porcentaje de acierto
    fprintf('Conjunto Nro. %d \n',i_k);
    [trn_data, val_data] = kfold(train_data,k,i_k);
    T = size(trn_data,1);   % Cantidad de patrones de entrenamiento
    V = size(val_data,1);   % Cantidad de patrones de validación

    capa_salida=length(RN); %Cantidad de capas de la RN

    w = cell(size(RN));  % Pesos de la RN
    w0 = cell(size(RN)); % Pesos de la RN (pesos de la iteración anterior)
    momento = cell(size(RN));

    RN_temp=[n_in; RN]; % Agrego la cantidad de entradas al vector
                            % que describe la RN
    H = zeros(1,max_ep);

    % Inicializo random                         
    for i=1:capa_salida
        w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
        w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
        momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    end

    while (epochs~=0 && hit_perc < tol)
        % una época de entrenamiento
        [w,w0] = mlp_train(trn_data,RN,w,w0,n_in,gamma,eta);

        % validación
        [hit_counter] = mlp_test(val_data,RN,w,n_in,n_out,phi,c);
        hit_perc = hit_counter/V*100;
        
        epochs=epochs-1;
        fprintf('Porcentaje de acierto (VAL)   %.2f, %d Epocas \n',hit_perc,max_ep-epochs);
        % historico de error para gráfica
        H(max_ep-epochs+1) = hit_perc;
    end
    % imprime el resultado con el que salió por validación del ciclo while
    
    valpk(i_k) = hit_perc;
    % verificación del resultado con los datos de entrenamiento
    [hit_counter] = mlp_test(trn_data,RN,w,n_in,n_out,phi,c);
    hit_perc = hit_counter/T*100;
    fprintf('[%d/%d]. Porcentaje de acierto (TRAIN) %.2f \n',i_k,k,hit_perc);
    % guardo los pesos y el porcentaje de acierto para el k-ésimo conjunto de entrenamiento
    wk(i_k,:,:) = w;
    trnpk(i_k) = hit_perc;
    nepk(i_k) = max_ep-epochs;
end % FIN DE K-FOLDING


% para quedarme con la mejor partición y poder probar con el conjunto de testeo armo una
% matriz auxiliar y la ordeno por porcentaje de acierto y cantidad de épocas
A = [(1:k)' nepk' trnpk' valpk'];
A = sortrows(A,[-3 -4 2]);
best = A(1,1);
w = wk(best,:,:);
% verificación del resultado con los datos de testeo
E = size(test_data,1);  % Cantidad de patrones de prueba
[hit_counter] = mlp_test(test_data,RN,w,n_in,n_out,phi,c);
hit_perc = hit_counter/E*100;
time = toc;
fprintf('Fin del entrenamiento... %.2f seg\n',time);
fprintf('Porcentaje de acierto (TEST)  %.2f \n',hit_perc);
fprintf('-------------------------------------------------------\n');

end

