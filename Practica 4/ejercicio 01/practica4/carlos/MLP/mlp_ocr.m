function [Tst,Trn,Val,time] = mlp_ocr(train_data,test_data,RN,n_in,n_out,tol,maxep,vrate,c,k)
    % fd:       'file descriptor' -> contiene el conjunto de datos
    % k:        cantidad de particiones de k-folding
    % RN:       arquitectura de la red neuronal
    % n_in:     cantidad de entradas (fd)
    % n_out:    cantidad de salidas (fd)
    % tol:      tolerancia -> mínimo porcentaje de acierto
    % maxep:    máxima cantidad de épocas de entrenamiento por partición
    % vrate:    tasa -> cantidad de patrones de entrenamiento que son usados para validación
    % Hk:       vector con el porcentaje de acierto para cada partición
    % Ek:       vector con la cantidad de épocas entrenadas en cada partición
    % time:     tiempo de ejecución total
    
    tic;
    phi = @(v,c) sigmoid(v,c);  % función de activación sigmoidea
    fprintf('RN = [ %d %d %d ]\n',RN(1),RN(2),RN(3));
    
    
    %%%%% REVISAR %%%%%
    eta = 0.05;                 % tasa de aprendizaje
    gamma = 0.1;                % coeficiente de momento
    
%     fprintf('Entrenando sigmoidea...\n');
%     c = learnc(fd,RN,n_in,n_out,phi,50,10) % parámetro de la sigmoidea

    fprintf('Comienzo del entrenamiento...\n');
    
    Trn = zeros(1,k);
    Tst = zeros(1,k);
    Val = zeros(1,k);
    
    train_data_in = train_data;
    
    parfor i_k = 1 : k
        [train_data,val_data] = kfold(train_data_in,k,i_k);
    
        capa_salida=length(RN); % cantidad de capas de la RN

        w = cell(size(RN));     % Pesos de la RN
        w0 = cell(size(RN));    % Pesos de la RN (pesos de la iteración anterior)
        momento = cell(size(RN));

        RN_temp=[n_in; RN];     % Agrego la cantidad de entradas al vector que describe la RN
        H = zeros(1,maxep);    % para ir llevando el histórico del porcentaje de acierto

        % Inicializo random                         
        for i=1:capa_salida
            w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
            w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
            momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
        end

        ep = 0;                 % contador de épocas
        hitp = 0;               % porcentaje de acierto para la época actual

        while ep < maxep && hitp < tol
            % una época de entrenamiento
            [w,w0] = mlp_train(train_data,RN,w,w0,n_in,gamma,eta,phi,c);

            % validación
            V = size(val_data,1);   % cantidad de patrones de validación
            [hit_counter] = mlp_test(val_data,RN,w,n_in,n_out,phi,c);
            hitp = hit_counter/V*100;
            
            ep = ep + 1;
            
%             fprintf('Porcentaje de acierto (VAL)   %.2f, %d Epocas \n',hitp,ep);
            % historico de error para gráfica
            H(ep) = hitp;
        end
        Val(i_k) = max(H(ep));
        
        T = size(train_data,1); % cantidad de patrones de entrenamiento
        [hit_counter] = mlp_test(train_data,RN,w,n_in,n_out,phi,c);
        Trn(i_k) = hit_counter/T*100;
        fprintf('[%d|%d]. Porcentaje de acierto (TRAIN) %.2f \n',i_k,k,Trn(i_k));

        E = size(test_data,1);  % Cantidad de patrones de prueba
        [hit_counter] = mlp_test(test_data,RN,w,n_in,n_out,phi,c);
        Tst(i_k) = hit_counter/E*100;
        fprintf('[%d|%d]. Porcentaje de acierto (TEST)  %.2f \n',i_k,k,Tst(i_k));
    end

    time = toc;
    fprintf('Fin del entrenamiento... %.2f seg\n',time);
    fprintf('-------------------------------------------------------\n');
    
end

