%% Guia 1 - Ejercicio 1 - a
clc;
clear;
addpath('../datosG02');

Data = csvread('irisbin.csv');
%[~,g] = leave_k_out(Data, 50, 1)


% Entrenamiento
DataLrn = csvread('Entrenamiento_2.csv');
Taza_Ap = 0.01;
MaxEp = 100;
TolEr = 50;
[n, m] = size(DataLrn);
Yd = DataLrn(:,end-2:end);

neu_capa_radial = 3;   % Numero Neuronas Capa Radial


%---- Caja Negra ----%
D = DataLrn(:,1:4);
k = 3;  % esto es siempre igual al numero de neuronas en la capa radial
[mu] = k_means(k, D);

X_y = zeros(n,neu_capa_radial);

W = rand(3,neu_capa_radial+1)-0.5;

for i=1:n
    X_y(i,:) = Capa_Radial(D(i,:),mu, neu_capa_radial); 
end

% Entrenamiento para los 3 perceptrones
for i=1:3
    [W(i,:),Sc,Ep,~,Y_sal(:,i)] = Entrena(X_y,Yd(:,i),W(i,:),Taza_Ap,MaxEp,TolEr);
    fprintf('Porcentaje de aciertos en entrenamiento: %.2f \nEpocas utilizadas: %d\n',Sc,Ep);
end
Y_salida=[Y_sal(:,1) Y_sal(:,2) Y_sal(:,3)];

%fprintf('\n--ENTRENAMIENTO--\n');


% %% Prueba
% DataTst = csvread('Prueba_1.csv');
% [n, m] = size(DataTst);
% D = DataTst(:,1:4);
% Yd = DataTst(:,end-2:end);
% 
% %---- Caja Negra ----%
% X_y = zeros(n,neu_capa_radial);
% 
% for i=1:n
%     X_y(i,:) = Capa_Radial(D(i,:),mu, neu_capa_radial); 
% end
% 
% % Llamo a la funcion para Prueba
% for i=1:3
%       [Sc, Y_sal] = Prueba(X_y,Yd(:,i),W(i,:));
%       fprintf('Porcentaje de aciertos en prueba: %.2f \n',Sc);
% end
% 
% fprintf('\n--PRUEBA--\n');
