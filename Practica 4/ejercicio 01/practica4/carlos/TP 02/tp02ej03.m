clear all; close all;
RN = [15 15];                       % red neuronal [cant. filas,cant. columnas]
k = 5;                              % cantidad de particiones para k folding
epochs = [25 75 50];                % cantidad de épocas por etapa de entrenamiento
factor = 4;                         % permite cambiar el tamaño de vecindad de la neurona ganadora
method = 1;                         % método de inicialización de los pesos: 1- aleatorio; 2- patrones aleatorios
gfreq = 5;                          % frecuencia a la que se actualiza la gráfica
file = 'clouds.csv';           % ruta del archivo de datos
% file = 'circulo.csv';             % ruta del archivo de datos
fd = csvread(file);                 % se lee el archivo de datos
fd = fd(randperm(size(fd,1))',:);   % desordeno los datos de entrada
n_inputs = 2;                       % se fija la cantidad de entradas
n_outputs = size(fd,2)-n_inputs;    % se calcula la cantidad de salidas

[train,test] = kfold(fd,k,1);       % k-folding (%% PROGRAMAR BUCLE!! %%)

T = size(test,1);                   % cantidad de patrones de test

[W] = trainSOM(train,n_inputs,RN,epochs,method,factor,gfreq);

[E] = labelSOM(W,train,n_inputs);

hit_perc = testSOM(W,E,test,n_inputs);