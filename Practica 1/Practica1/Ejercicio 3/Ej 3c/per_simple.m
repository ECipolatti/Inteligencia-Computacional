%% Guia 1 - Ejercicio 1
clc;
clear;
addpath('../archdatos');

%% Aprendizaje

% Leo los datos a utilizar

Data = csvread('/home/mario/Dropbox/4to Año - 2do Cuatrimestre/Inteligencia Computacional/Practica1/archdatos/concentlite.csv');      % Datos de entrada
DataLrn = radial(Data);

% Variables necesarias
LrnRt = 0.01;
MaxEp = 800;
TolEr = 6;
[n m] = size(DataLrn);
W0 = rand(1,m)-0.5;
X = DataLrn(:,1);
Yd = DataLrn(:,2);

% Llamo a la función
[W,Sc,Ep] = Learn1(X,Yd,W0,LrnRt,MaxEp,TolEr);
fprintf('Porcentaje de aciertos en el aprendizaje: %d\nCantidad de épocas utilizadas: %d\n',Sc,Ep);

%% Prueba

% Llamo a la función
[Sc,Yo] = Test1(X,Yd,W);
fprintf('Porcentaje de aciertos en la prueba: %d\n',Sc);
scatter(X,zeros(1,n),50,Yo,'x');
