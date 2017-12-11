close all; clear all;

phi = @(z) signo(z);

fd = csvread('concentlite.csv');
% fd = fd(randperm(size(fd,1))',:);      	% desordeno los datos de entrada
n_inputs = 2;                           % cantidad de entradas

% para corregir si los datos no son +1 y -1
for i = 1 : size(fd,1)
    if fd(i,n_inputs+1:end) == 0
        fd(i,n_inputs+1:end) = -1;
    end
end

n_outputs = size(fd,2)-n_inputs;        % cantidad de salidas
k = 5;                                  % parámetro k de k-folding
kc = 20;                                 % cantidad de centroides
maxep = 500;                            % cantidad máxima de épocas
epochs = maxep;                         % contador de épocas para el while
tol = 99;                               % porcentaje de acierto mínimo (tolerancia)
hit_perc = zeros(k,1);                  % porcentaje de acierto actual
eta = 0.005;                              % velocidad de aprendizaje

for i_k = 1 : k
    fprintf('Conjunto de datos de entrenamiento %d\n',i_k);
    [train,test] = kfold(fd,k,i_k);
    P = size(train,1);
    
    disp('Entrenando capa radial...');
    [index,cent,sigma] = kMeans(train(:,1:n_inputs),kc);
    
    N = size(cent,1);
    
    y_rbf = zeros(P,N);
    for i = 1 : P
        for j = 1 : N
            y_rbf(i,j) = exp(-1/2*norm(train(i,1:n_inputs)-cent(j,:)).^2);
        end
    end
    
    w = rand(n_outputs,N + 1) - 0.5;
    yd = train(:,n_inputs+1:end);
    x = [-ones(P,1) y_rbf];
    while (epochs > 0 && hit_perc(i_k) < tol)
        for i = 1 : P
            e = x(i,:)*w' - yd(i,:);
            w = w - eta*e'*x(i,:);
        end
        
        hit_counter = 0;
        for i = 1 : P
            y = phi(x(i,:)*w');
            hit_counter = hit_counter + (equal(y,yd(i,:)));
        end
        hit_perc(i_k) = hit_counter/P*100;
        fprintf('Porcentaje de acierto: %.2f, Epoca %d\n',hit_perc(i_k),maxep-epochs);
        epochs = epochs - 1;
        
    end
    epochs = maxep;
end

if (n_inputs == 2)
    X = train(:,1:2);
    Y = phi(x*w');
    for i = 1 : P
        if Y(i) ~= yd(i)
            Y(i) = 2;
        end
    end

    gscatter(X(:,1),X(:,2),Y,'kgr','..x');
    hold on;
    scatter(cent(:,1),cent(:,2),500);
end