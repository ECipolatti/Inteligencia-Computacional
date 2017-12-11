function [hitp] = mlp_eval(train_data,RN,n_in,n_out,gamma,eta,maxep,tol,phi,c)
    capa_salida=length(RN); % cantidad de capas de la RN
    
    w = cell(size(RN));     % Pesos de la RN
    w0 = cell(size(RN));    % Pesos de la RN (pesos de la iteración anterior)
    momento = cell(size(RN));

    RN_temp=[n_in; RN];     % Agrego la cantidad de entradas al vector que describe la RN

    % Inicializo random                         
    for i=1:capa_salida
        w{i} = rand(RN_temp(i+1),RN_temp(i)+1) - 0.5;
        w0{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
        momento{i} = zeros(RN_temp(i+1),RN_temp(i)+1);
    end
    
    ep = 1;
    hitp = 0;
    while ep < maxep && hitp < tol
        % una época de entrenamiento
        [w,w0] = mlp_train(train_data,RN,w,w0,n_in,gamma,eta,phi,c);

        % validación
        T = size(train_data,1);   % cantidad de patrones de validación
        [hit_counter] = mlp_test(train_data,RN,w,n_in,n_out,phi,c);
        hitp = hit_counter/T*100;

        ep = ep + 1;
    end

end

