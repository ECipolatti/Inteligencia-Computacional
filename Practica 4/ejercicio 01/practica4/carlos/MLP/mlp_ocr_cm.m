function [CM,Et,Tt,Ek,Tk] = mlp_ocr_cm(train_data,test_data,RN,n_in,n_out,tol,maxep,c,k)
    % train_data:   conjunto de datos de entrenamiento
    % test_data:    conjunto de datos de prueba
    % RN:           arquitectura de la red neuronal
    % n_in:         cantidad de entradas (fd)
    % n_out:        cantidad de salidas (fd)
    % tol:          tolerancia -> mínimo porcentaje de acierto
    % maxep:        máxima cantidad de épocas de entrenamiento por partición
    % c:            parámetro de ajuste de la sigmoidea
    % Tst:          vector con el porcentaje de acierto (TEST) para cada partición
    % Trn:          vector con el porcentaje de acierto (VAL) para cada partición
    % Val:          vector con el porcentaje de acierto (TRAIN) para cada partición
    % time:         tiempo de ejecución total
    tic;
    
    phi = @(v,c) sigmoid(v,c);  % función de activación sigmoidea
    fprintf('RN = [ %d %d %d ]\n',RN(1),RN(2),RN(3));
        
    %%%%% REVISAR %%%%%
    eta = 0.05;                 % tasa de aprendizaje
    gamma = 0.1;                % coeficiente de momento

    fprintf('Comienzo del entrenamiento...\n');
    Tt = zeros(1,k);
    Et = zeros(1,k);
    Tk = zeros(1,k);
    Ek = zeros(1,k);
    for i_k = 1 : k
        fprintf('Conjunto nro. %d\n',i_k);
        [train_data,val_data] = kfold(train_data,k,1);

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
        best = 0;
        ctr = 0;
        iddle = 5;
        while ep < maxep && hitp < tol && ctr < iddle
            % una época de entrenamiento
            [w,w0] = mlp_train(train_data,RN,w,w0,n_in,gamma,eta,phi,c);

            % validación
            V = size(val_data,1);   % cantidad de patrones de validación
            [hit_counter] = mlp_test(val_data,RN,w,n_in,n_out,phi,c);
            hitp = hit_counter/V*100;

            ep = ep + 1;

            fprintf('Porcentaje de acierto (VAL)   %.2f, %d Epocas \n',hitp,ep);
            % historico de error para gráfica
            H(ep) = hitp;

            if hitp > best
                best = hitp;
                ctr = 0;
            else
                ctr = ctr + 1;
            end
        end

        T = size(train_data,1); % cantidad de patrones de entrenamiento
        [hit_counter] = mlp_test(train_data,RN,w,n_in,n_out,phi,c);
        Ek(i_k) = hit_counter/T*100;
        fprintf('Porcentaje de acierto (TRAIN) %.2f \n',Ek(i_k));
        Et(i_k) = toc;
        fprintf('Fin del entrenamiento... %.2f seg\n',Et(i_k));


        tic;
        fprintf('Comienzo del testeo...\n');

        E = size(test_data,1);  % Cantidad de patrones de prueba
        [hit_counter,CM] = mlp_test_cm(test_data,RN,w,n_in,n_out,phi,c);
        Tk(i_k) = hit_counter/E*100;
        fprintf('Porcentaje de acierto (TEST)  %.2f \n',Tk(i_k));

        Tt(i_k) = toc;
        fprintf('Fin del testeo... %.2f seg\n',Tt(i_k));
        fprintf('-------------------------------------------------------\n');
    end
end

