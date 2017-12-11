a% EJERCICIO 4

close all; clear;
addpath('./datosG02');
Data = csvread('clouds.csv');
[n m] = size(Data);

%% creo el mapa
nro_filas = 10;
nro_columnas = 10;
c1 = 0; c2 = 0;

for i=1:nro_filas
    for j=1:nro_columnas
        mapa{i, j}.W = (rand(1,2)-.5)*15;
        mapa{i, j}.C = [c1 c2];
        mapa{i, j}.E = 0; 
    end
end

%% Armo Particiones para Entrenar y Probar
k = 1000;
[Particiones, g] = leave_k_out(Data, k, 0);


%% Entrenamiento
disp('Comienza el entrenamiento: ');
trn1 = csvread('Entrenamiento_1.csv');
[mapa] = trainSOM(trn1, mapa, nro_filas, nro_columnas);

%% Preba
disp('Comienza la prueba: ');
Tst1 = csvread('Prueba_1.csv');

[error]=TestSOM(Tst1,mapa,nro_filas,nro_columnas)
error= error/k*100
