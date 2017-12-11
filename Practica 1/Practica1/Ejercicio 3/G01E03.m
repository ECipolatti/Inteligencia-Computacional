% PERCEPTRON MULTICAPA 
addpath('../archdatos');
% Variables:
clear all; close all;

MaxEp = 400;        % Maximo Epocas
TolEr = 15;          % Tolerancia Error
MomRt = 0.3;        % Tasa momento
LearnRt = 0.1;     % Tasa aprendizaje

vec_num_neu = [5 1];                  % Vector Num de neuronas por capa
num_capas = length(vec_num_neu);        % Num de capas

Data = csvread('concentlite.csv');      % Datos de entrada
[n m] = size(Data);

X = [-ones(n,1) Data(:, 1:2)];           % Matriz X extendida
Yd = Data(:, 3);                         % MAtriz Yd, salidas deseadas
Y = zeros(n,1);
Y_aux1 = zeros(n,1);
Y_aux2 = zeros(n,1);

capa{1}.W = rand(vec_num_neu(1), length(X(1,:)))-0.5;
capa{1}.DW = zeros(vec_num_neu(1), length(X(1,:)));
capa{1}.Y = zeros(vec_num_neu(1), 1);
capa{1}.D = zeros(vec_num_neu(1), 1);
for i=2 : num_capas
    capa{i}.W = rand(vec_num_neu(i), vec_num_neu(i-1)+1) - 0.5;
    capa{i}.DW = zeros(vec_num_neu(i), vec_num_neu(i-1)+1);
    capa{i}.Y = zeros(vec_num_neu(i), 1);
    capa{i}.D = zeros(vec_num_neu(i), 1);
end

Ep = 1;
Er = 100;
%------- ENTRENAMIENTO -------%
while (Ep < MaxEp) && (TolEr < Er)
    % Calculando los mejores W
    for p=1 : n % p recorre por patron
        
        % Propagacion hacia Adelante
        capa{1}.Y = capa{1}.W * X(p, :)';
        capa{1}.Y = sigmoid(capa{1}.Y);
        for c=2 : num_capas     % c es indices de capas 
            capa{c}.Y = capa{c}.W * [-1; capa{c-1}.Y];
            capa{c}.Y = sigmoid(capa{c}.Y);
        end
        
        Y_aux1(p) = capa{num_capas}.Y;
        % Propagacion hacia atras - deltas
        error = Yd(p) - capa{num_capas}.Y;
        %Calculo los Deltas
        capa{num_capas}.D = 0.5 * error .* (1+capa{num_capas}.Y) .* (1-capa{num_capas}.Y);  % delta en la ultima capa
        for k=(num_capas-1): -1 : 1
             capa{k}.D = (capa{k+1}.W(:,2:end)' * capa{k+1}.D) .* 0.5 .* (1+capa{k}.Y) .* (1-capa{k}.Y);
        end
        
        % Actualizo los pesos
        %capa{1}.W = capa{1}.W + LearnRt * capa{1}.D * X(p,:); 
        capa{1}.DW = LearnRt * capa{1}.D * X(p,:) + MomRt * capa{1}.DW; % guardo DW 
        capa{1}.W = capa{1}.W + capa{1}.DW; % actualizo con momento
        
        for c=2 : num_capas
           %capa{c}.W = capa{c}.W + (LearnRt * capa{c}.D * [-1; capa{c-1}.Y]');
           capa{c}.DW = (LearnRt * capa{c}.D * [-1; capa{c-1}.Y]') + MomRt * capa{c}.DW; % guardo DW
           capa{c}.W = capa{c}.W + capa{c}.DW; % actualizo con momento
           
        end
    end  % end for - ACA TERMINA LA EPOCA DEJANDO EL MEJOR W PARA CADA CAPA 
    
    % Calculo porcentaje error
    Er = 0;
    for p=1 : n % p recorre por patron
        
        % Propagacion hacia Adelante
        capa{1}.Y = capa{1}.W * X(p,:)';
        capa{1}.Y = sigmoid(capa{1}.Y);
        for c=2 : num_capas % c es indices de capas 
            capa{c}.Y = capa{c}.W * [-1; capa{c-1}.Y];
            capa{c}.Y = sigmoid(capa{c}.Y);
        end
        Y_aux2(p) = capa{num_capas}.Y;   
        %Y(p) = capa{num_capas}.Y;
        Y(p) = sign(capa{num_capas}.Y);
        if Y(p) ~= Yd(p)
           Er = Er + 1;
        end
        %Er=Er+norm(Y(p)-Yd(p));
    end
    Er = (Er*100)/n;
    %Er
    % Incremento las Epocas
    Ep=Ep+1; 
end

%------- PRUEBA -------%
    Er = 0;
    for p=1 : n % p recorre por patron
        
        % Propagacion hacia Adelante
        capa{1}.Y = capa{1}.W * X(p,:)';
        capa{1}.Y = sigmoid(capa{1}.Y);
        for c=2 : num_capas % c es indices de capas 
            capa{c}.Y = capa{c}.W * [-1; capa{c-1}.Y];
            capa{c}.Y = sigmoid(capa{c}.Y);
        end
        Y_aux2(p) = capa{num_capas}.Y;   
        Y(p) = sign(capa{num_capas}.Y);
        if Y(p) ~= Yd(p)
           Er = Er + 1;
        end
    end
    Er = (Er*100)/n;
    fprintf('Porcentaje de error en la prueba: %d\n',Er);

figure(1)
grafica(X,Yd,Y);
% subplot(2,1,1)
% scatter(X(:,2),X(:,3),15,Yd);
% subplot(2,1,2)
% scatter(X(:,2),X(:,3),30,Y,'x');
%  plot(linspace(0,10,length(vec_error)),vec_error)


