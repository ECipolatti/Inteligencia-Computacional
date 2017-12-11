clear all; close all; clc;
addpath('../include');

dt = datestr(now,'yymmddHHMMSS');
diary(strcat('results/log',dt,'.txt'));
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

nbase = 20;      % incremento base de neuronas
ki = 1;          % cantidad de incrementos en la capa de entrada
kj = ki;         % cantidad de incrementos en la capa oculta
tol = 99.5;      % tolerancia -> mínimo porcentaje de acierto
maxep = 20;      % máxima cantidad de épocas de entrenamiento por partición
vrate = 0.2;	 % tasa -> cantidad de patrones de entrenamiento que son usados para validación
c = 0.5;         % parámetro de la sigmoidea
k = 10;          % parámetro de kfolding

stats = zeros(ki*kj,(3*(k+1)+1)); % para llevar las estadísticas
it = 1;          % inicializo el contador de iteraciones
flag = 0;        % bandera para indicar si hay que cortar el entrenamiento
% l1 = linspace(nbase,nbase*ki,ki);   % cantidad de neuronas de la capa de entrada
% l2 = l1;       % cantidad de neuronas de la capa oculta
l1 = 40;
l2 = 100;
l3 = n_out;      % cantidad de neuronas de la capa de salida

for i = 1 : ki
    for j = 1 : kj
       RN = [l1(i) l2(j) l3]';   % definición de la arquitectura de la red
       stats(it,1:3) = RN;
       [Tst,Trn,Val,time] = mlp_ocr(train_data,test_data,RN,n_in,n_out,tol,maxep,vrate,c,k);
       stats(it,4:end) = [Tst,Trn,Val,time];
       if mean(Tst) > tol
           flag = 1;
           break;
       end
       it = it + 1;
   end
   if flag
       break;
   end
end

ttime = sum(stats(:,end));

A = [stats(:,1:3) mean(stats(:,4:4+k-1),2) std(stats(:,4:4+k-1),0,2) ... 
    mean(stats(:,4+k:4+2*k-1),2) std(stats(:,4+k:4+2*k-1),0,2)...
    mean(stats(:,4+2*k:4+3*k-1),2) std(stats(:,4+2*k:4+3*k-1),0,2)...
    stats(:,end)];
A = sortrows(A,[-4 -5 -6]);

hend = datestr(now,'yyyy-mm-dd HH:MM:SS');

[aux_T,aux_V] = kfold(train_data,k,1);
T = size(aux_T,1);
V = size(aux_V,1);
E = size(test_data,1);

fprintf('Fin:                %s\n',hend);
fprintf('Tiempo total:       %.2f seg (%.2f min - %.2f hr)\n',ttime,ttime/60,ttime/3600);
fprintf('Entrenamiento:      %d Epocas\n',maxep);
fprintf('Mejor arquitectura: [ %d %d %d ]\n',A(1,1:3));
fprintf('Datos de Ent. / Val. / Prueba (%d conjuntos): %d / %d / %d\n',k,T,V,E);
fprintf('Promedios:\n');
fprintf('ENTRENAMIENTO:      %.2f %% (stdev %.2f)\n',A(1,6:7));
fprintf('PRUEBA:             %.2f %% (stdev %.2f)\n',A(1,4:5));

fileID = fopen('results/test_ocr.txt','wt');
fprintf(fileID,'Inicio:             %s\n',hstart);
fprintf(fileID,'Fin:                %s\n',hend);
fprintf(fileID,'Tiempo total:       %.2f seg (%.2f min - %.2f hr)\n',ttime,ttime/60,ttime/3600);
fprintf(fileID,'Entrenamiento:      %d Epocas\n',maxep);
fprintf(fileID,'Mejor arquitectura: [ %d %d %d ]\n',A(1,1:3));
fprintf(fileID,'Datos de Ent. / Val. / Prueba (%d conjuntos): %d / %d / %d\n',k,T,V,E);
fprintf(fileID,'Promedios:\n');
fprintf(fileID,'ENTRENAMIENTO:      %.2f %% (stdev %.2f)\n',A(1,6:7));
fprintf(fileID,'PRUEBA:             %.2f %% (stdev %.2f)\n',A(1,4:5));
fclose('all');

csvwrite('results/test_ocr.csv',stats);
diary off;