%% Guia 2 - Ejercicio 1b - Clasificacion IRIS
tic();
clc;
clear all;
close all;
addpath('../datosG02');
Data = csvread('irisbin.csv');

Tasa_Ap = 0.1;
MaxEp = 1000;
TolEr = 6;

[ ~ ,g ] = leave_k_out(Data, 20, 0);

numero_neu = 25;

vec_error_Train = zeros(1, g);
vec_error_Test = zeros(1, g);

W = rand(numero_neu,numero_neu+1)-0.5;

for p=1 : g
    Nom_E = strcat('Entrenamiento_', strcat(int2str(p),'.csv'));
    Nom_P = strcat('Prueba_', strcat(int2str(p),'.csv'));
    Data_Train = csvread(Nom_E);
    Data_Test = csvread(Nom_P);
    
    % -- ENTRENAMIENTO --
    D = Data_Train(:,1:4);
    [n ,~] = size(D);
    Yd = Data_Train(:,5:end);
    [mu, ~] = k_means( numero_neu, D );
    [ X_y ] = C_Radial(D, mu);
    for i=1:3
        [Wl(i,:),Er,Ep,vec_Er,Y_e(:,i)] = Entrena (X_y,Yd(:,i),W(i,:),Tasa_Ap,MaxEp,TolEr);
    end
    Salida_E = [Y_e(:,1) Y_e(:,2) Y_e(:,3)];
    Salida_E = Codifica(Salida_E);
    
    Er = 0;
    for i = 1:n
        if ~isequal(Salida_E(i,:), Yd(i,:))
            Er = Er + 1;
        end
    end
    ErTrain = (Er*100)/n;
    vec_error_Train(p) = ErTrain;
    
    % -- PRUEBA --
    D = Data_Test(:,1:4);
    [n ,~] = size(D);
    Yd = Data_Test(:,5:end);
    [ X_y ] = C_Radial(D, mu);
    for i=1:3
        [Er, Y_s(:,i)] = Prueba(X_y,Yd(:,i),Wl(i,:));
    end
    Salida_P = [Y_s(:,1) Y_s(:,2) Y_s(:,3)];
    Salida_P = Codifica(Salida_P);
    
    Er = 0;
    for i = 1:n
        if ~isequal(Salida_P(i,:), Yd(i,:))
            Er = Er + 1;
        end
    end
    ErTest = (Er*100)/n;
    vec_error_Test(p) = ErTest;
    
    fprintf('Error promedio en el Entrenamiento de la Particion %d  =  %.3f \n' , p, ErTrain);
    fprintf('Error promedio en la Prueba de la Particion %d  =  %.3f \n' , p, ErTest);
 
end
fprintf('\nError Promedio en el Entrenamiento =  %.3f - Desvio = %.3f \n', mean(vec_error_Train), std(vec_error_Train));
fprintf('Error Promedio en la Prueba =  %.3f - Desvio = %.3f \n' , mean(vec_error_Test), std(vec_error_Test));
time=toc();
fprintf('\nTiempo del proceso: %.3f\n' ,time);
