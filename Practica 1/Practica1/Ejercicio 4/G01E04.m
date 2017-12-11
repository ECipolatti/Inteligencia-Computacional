% PERCEPTRON MULTICAPA con Salidas Multiples
tic();
addpath('../archdatos');
% Variables:
clear all; close all;

MaxEp = 1000;        % Maximo Epocas
TolEr = 6;          % Tolerancia Error
MomRt = 0.5;        % Tasa momento
LearnRt = 0.1;      % Tasa aprendizaje
num_salidas = 3;    % Numero Salidas
num_entradas = 4;   % Numero Entradas
vec_num_neu = [4 3];     % Vector Num de neuronas por capa
Data_Original = csvread('irisbin.csv');      % Datos de entrada sin particionar

[~, g] = leave_k_out(Data_Original, 20, 0);

vec_error_Train = zeros(1, g);
vec_error_Test = zeros(1, g);

for i=1 : g
    Nom_E = strcat('Entrenamiento_', strcat(int2str(i),'.csv'));
    Nom_P = strcat('Prueba_', strcat(int2str(i),'.csv'));
    Data_Train = csvread(Nom_E);
    Data_Test = csvread(Nom_P);
    
    [capa, ErTrain,Ep] = Entrena (Data_Train, LearnRt, MomRt, MaxEp, TolEr, num_salidas, num_entradas, vec_num_neu);
    [ErTest] = Prueba(Data_Test,capa, num_salidas, num_entradas, vec_num_neu);
    
    fprintf('\nError promedio en el Entrenamiento de la Particion %d  =  %.3f \n' , i, ErTrain);
    fprintf('Error promedio en la Prueba de la Particion %d  =  %.3f\n' , i, ErTest);
    vec_error_Train(i) = ErTrain;
    vec_error_Test(i) = ErTest;
end
fprintf('\nError Promedio en el Entrenamiento =  %.3f - Desvio = %.3f \n', mean(vec_error_Train), std(vec_error_Train));
fprintf('Error Promedio en la Prueba =  %.3f - Desvio = %.3f \n' , mean(vec_error_Test), std(vec_error_Test));
time = toc();
fprintf('Tiempo de proceso =  %.3f\n',time);






