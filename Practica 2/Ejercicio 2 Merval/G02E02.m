%% Guia 2 - Ejercicio 2 - Merval
clc;
clear all;
close all;
addpath('../datosG02');
Data = csvread('merval.csv');

figure(1);
plot(Data,'b');
hold on

Tasa_Ap = 0.1;
MaxEp = 5000;
TolEr = 6;
Dif_Er = 30;
[Data_nueva] = Crea_Patrones(Data);
[Data_nueva, ind] = mezclar(Data_nueva);
datos_prueba = 100;

Data_Entrena =Data_nueva(1:(end-datos_prueba),:);
Data_Prueba = Data_nueva(end-datos_prueba+1:end,:);

Yd = Data_Entrena(:,6);
D = Data_Entrena(:,1:5);

neu_capa_radial = 18;   % Numero Neuronas Capa Radial = k medias
[cellClases, mu] = k_means(neu_capa_radial, D);

[ matriz_sigmas_k ] = Var(neu_capa_radial, cellClases, 5);

[indices] = Clasifica(D, mu);

[ X_y ] = C_Radial(D, mu, matriz_sigmas_k);


%% Entrenamiento
fprintf('--ENTRENAMIENTO--\n');
W = rand(1,neu_capa_radial+1)-0.5;

[Wl,Er,Ep,vec_er,Y_salE] = Entrena (X_y,Yd,W,Tasa_Ap,MaxEp,TolEr, Dif_Er);
fprintf('Porcentaje de error en entrenamiento: %.2f \nEpocas: %d\n',Er,Ep);
Ent=[Yd Y_salE abs(Y_salE(:)-Yd(:))];
Dif = abs(Y_salE(:)-Yd(:));
% plot(vec_er(1:Ep));
% axis([0 Ep 0 100]);

%% Prueba
fprintf('\n--PRUEBA--\n');
Yd = Data_Prueba(:,6);
D_P = Data_Prueba(:,1:5);

%---- Caja Negra ----%
[ X_y ] = C_Radial(D_P, mu, matriz_sigmas_k);

% Llamo a la funcion para Prueba
[Er, Y_salP] = Prueba(X_y,Yd,Wl,Dif_Er);
fprintf('Porcentaje de error en prueba: %.2f \n',Er);

Todo = [Y_salE; Y_salP];

plot(Ordena(Todo,ind),'r');





