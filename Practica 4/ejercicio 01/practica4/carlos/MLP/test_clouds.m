clear all; close all; clc;
addpath('../include');

dt = datestr(now,'yymmddHHMMSS');
diary(strcat('results/log',dt,'.txt'));
hstart = datestr(now,'yyyy-mm-dd HH:MM:SS');
fprintf('Inicio:             %s\n',hstart);

fd = csvread('clouds2.csv');
fd = fd(randperm(size(fd,1)),:);
fd = fd(1:2000,:);

n_in = 2;                   % cantidad de entradas (definido por el usuario)
n_out = size(fd,2) - n_in;  % cantidad de salidas (total columnas (-) cantidad entradas)

% si n_ouputs no es entero mayor o igual a 1 no se puede continuar
if (n_out < 1)
    error('Cantidad insuficiente de salidas');
end

nbase = 4;      % incremento base de neuronas
ki = 10;         % cantidad de incrementos en la capa de entrada
kj = ki;        % cantidad de incrementos en la capa oculta
tol = 95;       % tolerancia -> mínimo porcentaje de acierto
k = 3;          % parámetro k para k-folding
maxep = 150;    % máxima cantidad de épocas de entrenamiento por partición
vrate = 0.2;	% tasa -> cantidad de patrones de entrenamiento que son usados para validación
c = 1;          % parámetro de la sigmoidea

stats = zeros(ki*kj,(3+k+k+1)); % para llevar las estadísticas
it = 1;          % inicializo el contador de iteraciones
flag = 0;       % bandera para indicar si hay que cortar el entrenamiento
l1 = linspace(nbase,nbase*ki,ki);   % cantidad de neuronas de la capa de entrada
l2 = l1;        % cantidad de neuronas de la capa oculta
l3 = n_out;     % cantidad de neuronas de la capa de salida

for i = 1 : ki
    for j = 1 : kj
       RN = [l1(i) l2(j) l3]';   % definición de la arquitectura de la red
       stats(it,1:3) = RN;
       [Hk,Ek,time] = mlp_kfold(fd,k,RN,n_in,n_out,tol,maxep,vrate,c);
       stats(it,4:end) = [Hk,Ek,time];
       if mean(Hk) > tol
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
    mean(stats(:,4+k:4+2*k-1),2) stats(:,end)];
A = sortrows(A,[-4 -5 6]);

hend = datestr(now,'yyyy-mm-dd HH:MM:SS');

fprintf('Fin:                %s\n',hend);
fprintf('Tiempo total: %.2f seg (%.2f min - %.2f hr)\n',ttime,ttime/60,ttime/3600);
fprintf('Mejor arquitectura: [ %d %d %d ]\n',A(1,1:3));
fprintf('Promedios: %.2f %% acierto (stdev %.2f) - %d Epocas - %.2f seg\n',A(1,4:end));

fileID = fopen('results/test_clouds.txt','wt');
fprintf(fileID,'Inicio:             %s\n',hstart);
fprintf(fileID,'Fin:                %s\n',hend);
fprintf(fileID,'Tiempo total:       %.2f seg (%.2f min - %.2f hr)\n',ttime,ttime/60,ttime/3600);
fprintf(fileID,'Mejor arquitectura: [ %d %d %d ]\n',A(1,1:3));
fprintf(fileID,'Promedios:          %.2f %% acierto (stdev %.2f) - %d Epocas - %.2f seg\n',A(1,4:end));
fclose('all');

csvwrite('results/test_clouds.csv',stats);
diary off;