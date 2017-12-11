function [er,nep,w] = perceptron_train(M,desc,lf,nep,tol,sg)
    phi = @(z) signo(z);
    [n,m] = size(M);    % n: nro. de filas; m: nro. de columnas
    er = 100;           % inicializo al máximo la tasa de error
    maxep = nep;        % máximo nro. de épocas
    
    w = rand(1,m) - 0.5;% inicializo el vector de pesos (aleatorio [-0.5,0.5]
    % si está activada la visualización de gráficas creo una nueva figura
    if sg == 1
        figure('Name',desc);
    end
    
    while nep > 0 && er > tol
        % primero entreno el perceptrón con todos los patrones
        for i = 1 : n
            [~,w] = perceptron(M(i,1:m-1),w,lf,M(i,m),phi);
            
        end
        
        % gráficas de entrenamiento (si la opción sg está activada)
        if sg == 1
            if m == 3
                graph2D(w,M,desc);
            end
            if m == 4 && sg == 1
                graph3D(w,M,desc);
            end
        end
        
        % con el último vector w "aprendido" calculo nuevamente y = phi(z)
        % y mido el error contra el valor deseado. se cuentan la cantidad
        % de aciertos y se saca un porcentaje (para usar como corte)
        e = 0;
        for i = 1 : n
            [y,~] = perceptron(M(i,1:m-1),w,lf,M(i,m),phi);
            yd = M(i,m);
            if yd - y ~= 0
                e = e+1;
            end
        end
        er = e/n*100;   % er: tasa de error: nro. errados/total

        nep = nep - 1;  % decrementa el contador de épocas
        fprintf('Porcentaje de error %.4f, Epoca: %d  \n',er, maxep-nep);
    end
end
