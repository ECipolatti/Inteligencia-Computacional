clear all; close all; clc;
addpath('../include');

dt = datestr(now,'yymmddHHMMSS');
% diary(strcat('results/log',dt,'.txt'));
hstart = datestr(now,'yyyy-mm-dd HH:MM:SS');
fprintf('Inicio:             %s\n',hstart);

NTrain = 60000; % Training samples
NTest = 10000;  % Testing samples

[train_data, test_data] = readMNISTDataset ('train-images.idx3-ubyte', ...
    'train-labels.idx1-ubyte', ...
    't10k-images.idx3-ubyte', ...
    't10k-labels.idx1-ubyte',...
    NTrain, NTest);

n_in = 400; % cantidad de entradas (definido por el usuario)
% n_out = size(train_data,2) - n_in;  % cantidad de salidas (total de columnas
%                                     % menos la cantidad de entradas)
n_out = 10;

tol = 97.5;      % tolerancia -> mínimo porcentaje de acierto
maxep = 250;     % máxima cantidad de épocas de entrenamiento por partición
c = 0.5;         % parámetro de la sigmoidea
k = 5;           % parámetro de kfolding

l1 = 100;
l2 = 40;
l3 = n_out;      % cantidad de neuronas de la capa de salida

RN = [l1 l2 l3]';
[CM,Et,Tt,Ek,Tk] = mlp_ocr_cm(train_data,test_data,RN,n_in,n_out,tol,maxep,c,k);

A = [median(Et) std(Et) mean(Tt) std(Tt) mean(Ek) std(Ek) mean(Tk) std(Tk)];

fprintf('Tiempo promedio de entrenamiento: %.2f (stdev %.2f)\n',A(1:2));
fprintf('Tiempo promedio de prueba: %.2f (stdev %.2f)\n',A(3:4));
fprintf('Porcentaje de acierto de entrenamiento: %.2f (stdev %.2f)\n',A(5:6));
fprintf('Porcentaje de acierto de prueba: %.2f (stdev %.2f)\n',A(7:8));