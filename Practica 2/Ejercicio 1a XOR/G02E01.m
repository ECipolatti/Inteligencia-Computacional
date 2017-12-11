%% Guia 1 - Ejercicio 1
clc;
clear all;
addpath('../datosG02');

% Datos a utilizar
% Utilizar 'OR' o 'XOR' segun corresponda
Tipo = 'XOR';
DataLrn = csvread(strcat(Tipo,'_trn.csv'));

% Variables
Taza_Ap = 0.1;
MaxEp = 500;
TolEr = 0.1;
[n, m] = size(DataLrn);
Yd = DataLrn(:,end);

num_salidas = 1;    % Numero Salidas
neu_capa_radial = 8;   % Numero Neuronas Capa Radial

%---- Caja Negra ----%
D = DataLrn(:,1:(m-1));
[mu] = k_means(neu_capa_radial, D); %Obtengo mi vector de medias
[X_y] = C_Radial(D, mu);  %Obtengo mis salidas de todas las k neuronas

figure(1);
hold on
scatter(D(:,1),D(:,2),30,'b');
scatter(mu(:,1),mu(:,2),30,'r');
hold off

%% -- ENTRENAMIENTO -- %
W0 = rand(1,neu_capa_radial+1)-0.5;
[W,Er,Ep,vec_Er,Y_l] = Entrena(X_y,Yd,W0,Taza_Ap,MaxEp,TolEr);
Ent = [Yd Y_l];
% figure(2);
% plot(linspace(1,10,length(vec_Er)),vec_Er,'r','LineWidth',1);
% title('Error por Epoca');
% axis([0,length(vec_Er),0,100]);
fprintf('\n--ENTRENAMIENTO--\n');
fprintf('Porcentaje de error en entrenamiento: %.2f \nEpocas: %d\n',Er,Ep);

%% -- PRUEBA -- %

% Datos a utilizar
DataTst = csvread(strcat(Tipo,'_tst.csv'));
[n, m] = size(DataTst);
D = DataTst(:,1:(m-1));
Yd = DataTst(:,end);

%---- Caja Negra ----%
[X_y] = C_Radial(D, mu);  %Obtengo mis salidas de todas las k neuronas

[Er, Y_sal] = Prueba(X_y,Yd,W);
Prue = [Yd Y_sal];

fprintf('\n--PRUEBA--\n');
fprintf('Porcentaje de error en prueba: %.2f \n',Er);