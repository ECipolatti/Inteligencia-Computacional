function [A,eta] = paramSOM(epochs,RN,factor)
    % recibe como entradas las cantidades de épocas para cada etapa del entrenamiento y
    % arma un vector de vecindad y otro de velocidad de aprendizaje con un valor propio
    % para cada iteración según las fórmulas de cálculo prefijadas. para fijar la 
    % la vecindad inicial se usa el parámetro factor. mientras mayor sea el factor, 
    % menor será la vecindad
    
    if length(epochs) < 3
        error('Falta especificar las épocas para alguna fase del entrenamiento');
    end
    %% parámetros configurables
    % valores para la velocidad de aprendizaje en la primera etapa de entrenamiento
    eta_a = 0.9;
    eta_b = 0.7;
    % valor final al que se llega de velocidad de aprendizaje. afecta a las etapas 2 y 3 
    % de entrenamiento
    eta_f = 0.1; 
    
    %% parámetros fijos (calculados)
    a = 1; b = epochs(1);           % primera etapa de entrenamiento a-b
    c = b+1; d = c+epochs(2)-1;     % segunda etapa de entrenamiento c-d
    e = d+1; f = e+epochs(3)-1;     % tercera etapa de entrenamiento e-f
    
    % tomo los 3 primeros valores, para evitar errores si se ingresaran datos de más
    E = sum(epochs(1:3));
    % A: vecindad (debiese ser lambda, pero es más corto A ñ_ñ)
    A = zeros(E,1);
    % eta: velocidad de aprendizaje
    eta = zeros(E,1);
    
    % primera etapa de entrenamiento: A grande (medio mapa) y eta grande (entre 0.9 y 0.7)
    A(a:b) = (RN(1)*RN(2))/(factor*min(RN)); 
    eta(a:b) = linspace(eta_a,eta_b,epochs(1));
    
    % segunda etapa de entrenamiento: A se reduce linealmente hasta 1 y eta se reduce
    % exponencialmente hasta 0.1 (notar que arranco desde uno antes... es para que el
    % descenso continúe y no se repitan los 2 valores límite entre las etapas 2 y 3 de
    % entrenamiento
    A(c:d) = linspace(A(b),1,epochs(2));
    eta(c-1:d) = exp(linspace(log(eta_b),log(eta_f),epochs(2)+1));
%     eta(c-1:d) = linspace(eta_b,eta_f,epochs(2)+1);
    
    % tercera etapa de entrenamiento: A se mantiene constante en cero (se actualiza sólo
    % la neurona ganadora) y eta se mantiene constante en [0.1-0.01]
    eta(e:f) = eta_f;
end

