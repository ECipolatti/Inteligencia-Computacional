function [W] = trainSOM(train,n_inputs,RN,epochs,method,factor,gfreq)
    % --------------------------------------------------------------------------------------%
    % file:     ruta del archivo de datos (.csv)                                            %
    % n_inputs: cantidad de entradas                                                        %
    % RN:       estructura de la Red Neuronal                                               %
    % epochs:   cantidad de épocas para las 3 fases de entrenamiento del SOM                %
    % method:   método de inicialización de los pesos: 1- aleatorio; 2- patrones aleatorios %
    % factor:   permite cambiar el tamaño de vecindad de la neurona ganadora                %
    % gfreq:    frecuencia de actualización de la gráfica de entrenamiento (en épocas)      %
    % W:        cell array con los pesos de cada neurona (dimensiones: LxHxn_inputs)        %
    % --------------------------------------------------------------------------------------%
    
    if method == 2                          % inicialización de los pesos a partir de los datos
        W = weightSOM(RN,n_inputs,train(:,1:n_inputs));
    else                                    % sino...inicialización de los pesos aleatorios
        W = weightSOM(RN,n_inputs);                  
    end
    
    [A,eta] = paramSOM(epochs,RN,factor);        % inicialización de los parámetros A y eta del SOM
    % gráfica inicial del SOM
    figure;
    graphSOM(W);
    
    maxep = sum(epochs);                    % cantidad total de épocas
    epctr = 0;                              % contador de épocas
    P = size(train,1);                      % cantidad de patrones de entrenamiento
    while epctr < maxep
        if (epctr == 0)
            disp('Primera fase: ordenamiento global...');
        end
        if (epctr == epochs(1))
            disp('Segunda fase: transición...');
        end
        if (epctr == maxep-epochs(3))
            disp('Tercera fase: ajuste fino...');
        end
        epctr = epctr+1;                    % incrementa el contador de épocas
        for i = 1 : P
            % patrón de entrenamiento actual
            pattern = train(i,1:n_inputs);
            % fila y columna de la neurona ganadora
            [wrow,wcol] = findWinner(W,pattern,n_inputs);    
            % se calcula la vecindad de la ganadora: tl (top left) br (bottom right) son la
            % fila y columna de las esquinas del rectángulo formado por el SOM
            [tl,br] = neighbours(wrow,wcol,RN,A(epctr));
            for row = tl(1) : br(1)
                for col = tl(2) : br(2)
                    if(abs(wrow-row)+abs(wcol-col)<=round(A(epctr)))
                        W{row,col} = W{row,col} + eta(epctr)*(pattern - W{row,col});
                    end
                end
            end
        end
        if mod(epctr,gfreq) == 0
            graphSOM(W);
        end

        fprintf('Epoca: %d\t- A: %.4f - eta: %.4f\n',epctr,A(epctr),eta(epctr));
    end

    hold on;
    scatter(train(:,1),train(:,2));
end

