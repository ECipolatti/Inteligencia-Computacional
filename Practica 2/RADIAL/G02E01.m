%% Guia 1 - Ejercicio 1
clc;
clear;
close all;
addpath('../datosG02');

% Aprendizaje

% Leo los datos a utilizar
% Utilizar 'OR' o 'XOR' segun corresponda
Tipo = 'XOR';
DataLrn = csvread(strcat(Tipo,'_trn.csv'));

% Variables necesarias
Taza_Ap = 0.1;
MaxEp = 50;
TolEr = 0.1;
[n, m] = size(DataLrn);
Yd = DataLrn(:,end);

num_salidas = 1;    % Numero Salidas
neu_capa_radial = 4;   % Numero Neuronas Capa Radial

%---- Caja Negra ----%
D = DataLrn(:,1:(m-1));
k = 4;
[mu] = k_means(k, D);

X_y = zeros(n,neu_capa_radial);
W0 = rand(1,neu_capa_radial+1)-0.5;

for i=1:n
    X_y(i,:) = Capa_Radial(D(i,:),mu, neu_capa_radial); 
end

figure(1);
hold on
scatter(D(:,1),D(:,2),30);
scatter(mu(:,1),mu(:,2),30,'r');
hold off

% Llamo a la funcion de entrenamiento
[W,Sc,Ep,vec_Er,Y_l] = Entrena(X_y,Yd,W0,Taza_Ap,MaxEp,TolEr);
J = [Yd Y_l];
% figure(2);
% plot(linspace(1,10,length(vec_Er)),vec_Er,'r','LineWidth',1);
% title('Error por Epoca');
% axis([0,length(vec_Er),0,100]);
fprintf('\n--ENTRENAMIENTO--\n');
fprintf('Porcentaje de aciertos en entrenamiento: %.2f \nEpocas utilizadas: %d\n',Sc,Ep);

%% Prueba

% Leo los datos a utilizar
DataTst = csvread(strcat(Tipo,'_tst.csv'));
[n, m] = size(DataTst);
D = DataTst(:,1:(m-1));
Yd = DataTst(:,end);

%---- Caja Negra ----%
X_y = zeros(n,neu_capa_radial);

for i=1:n
    X_y(i,:) = Capa_Radial(D(i,:),mu, neu_capa_radial); 
end

% Llamo a la funcion para Prueba
[Sc, Y_sal] = Prueba(X_y,Yd,W);

fprintf('\n--PRUEBA--\n');
fprintf('Porcentaje de aciertos en prueba: %.2f \n',Sc);