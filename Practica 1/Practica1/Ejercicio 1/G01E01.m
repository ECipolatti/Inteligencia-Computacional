%% Guia 1 - Ejercicio 1
clc;
clear;
addpath('../archdatos');

%% Aprendizaje

% Leo los datos a utilizar
% Utilizar 'OR' o 'XOR' segun corresponda
Tipo = 'XOR';
DataLrn = csvread(strcat(Tipo,'_trn.csv'));

% Variables necesarias
Taza_Ap = 0.1;
MaxEp = 50;
TolEr = 26;
m = size(DataLrn,2);
W0 = rand(1,m)-0.5;
X = DataLrn(:,1:2);
Yd = DataLrn(:,end);

% Llamo a la funcion de entrenamiento
[W,Sc,Ep,vec_Er] = Entrena(X,Yd,W0,Taza_Ap,MaxEp,TolEr);
figure(2);
plot(linspace(1,10,length(vec_Er)),vec_Er,'r','LineWidth',1);
title('Error por Epoca');
axis([0,length(vec_Er),0,100]);
fprintf('\n--ENTRENAMIENTO--\n');
fprintf('Porcentaje de aciertos en entrenamiento: %.2f \nEpocas utilizadas: %d\n',Sc,Ep);

%% Prueba

% Leo los datos a utilizar
DataTst = csvread(strcat(Tipo,'_tst.csv'));

% Variables necesarias
X = DataTst(:,1:2);
Yd = DataTst(:,end);

% Llamo a la funcion para Prueba
[Sc] = Prueba(X,Yd,W);
fprintf('\n--PRUEBA--\n');
fprintf('Porcentaje de aciertos en prueba: %.2f \n',Sc);