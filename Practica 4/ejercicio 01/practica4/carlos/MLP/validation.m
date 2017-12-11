function [train_out,val] = validation(train_in,rate)
    % train_in:     conjunto de datos de entrenamiento
    % rate:         tasa -> cantidad de patrones que serán de validación
    % train_out:    datos que quedan para entrenamiento
    % val:          datos que quedan para validación
    T = size(train_in,1);               % cantidad total de patrones
    N = round((1-rate)*T);              % cantidad de patrones para entrenamiento
    idx = randperm(T);                  % permutación aleatoria de números de 1 a N
    train_out = train_in(idx(1:N),:);   % primeros N patrones aleatorios para entrenamiento
    val = train_in(idx(N+1:end),:);     % últimos (T-N) patrones aleatorios para validación
end

