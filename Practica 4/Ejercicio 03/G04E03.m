close all; 
clear all; 
clc;

addpath('../Datos');
D7 = csvread('7cities.csv');
nodo_origen7 = 7;

D10 = csvread('10cities.csv');
nodo_origen10 = 5;

%% Colonia de Hormigas:
method = 'g'; % Puede ser 'g' (global), 'u' (uniforme) o 'l' (local)
N = 10; % Cantidad de hormigas
Q = 1;
beta = 1;
alpha = 1;
rho = 0.8;

disp('Comienza la Colonia de Hormigas con archivo 7cities: ');

[CaminoH7, CostoH7, time] = ColoniaHormigas(N, Q, rho, alpha, beta, D7, nodo_origen7, method);

fprintf('tiempo requerido: %d seg \n',time)
fprintf('Mejor camino encontrado es: %s \n',num2str(CaminoH7))
fprintf('Costo del camino encontrado: %d \n\n',CostoH7)

disp('Comienza la Colonia de Hormigas con archivo 10cities: ');

[CaminoH10, CostoH10, time] = ColoniaHormigas(N, Q, rho, alpha, beta, D10, nodo_origen10, method);

fprintf('tiempo requerido: %d seg \n',time)
fprintf('Mejor camino encontrado es: %s \n',num2str(CaminoH10))
fprintf('Costo del camino encontrado: %d \n\n',CostoH10)


%% Busqueda de Costo Uniforme:
disp('Comienza Busqueda de Costo Uniforme con archivo 7cities: ');

[Camino7, Costo7,time] = UCS(D7, nodo_origen7);

fprintf('Tiempo Requerido: %d seg \n',time)
fprintf('Mejor camino encontrado es: %s \n',num2str(Camino7))
fprintf('Costo del camino encontrado: %d \n\n',Costo7)

disp('Comienza Busqueda de Costo Uniforme con archivo 10cities: ');

[Camino10, Costo10,time] = UCS(D10, nodo_origen10);

fprintf('Tiempo Requerido: %d seg \n',time)
fprintf('Mejor camino encontrado es: %s \n',num2str(Camino10))
fprintf('Costo del camino encontrado: %d \n\n',Costo10)