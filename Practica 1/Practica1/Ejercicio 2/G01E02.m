%% Guia 1 - Ejercicio 2
clc;
clear;
addpath('../archdatos');

%% Entrenamiento

% Leo los datos a utilizar y realizo las particiones
DataLrn = csvread('spheres2d70.csv');
nro_part=3;
por_trn=80;
[DTrn , DTst]= particion(nro_part, por_trn, DataLrn);

% Llamo a la funcion de aprendizaje con cada particion 
 tasa_ep = 0.1;
 MaxEp = 40;
 TolEr = 1;
 m = size(DTrn,2); %Columnas de DataLrn
 vec_Er = zeros(1,nro_part);
 vec_W = zeros(m,1,1,nro_part);
 figure(1);
for i=1:nro_part
    fprintf('\nparticion: %d\n',i);
    
    W0 = rand(1,m)-0.5;
    X = DTrn(:,1:3,1,i);
    Yd = DTrn(:,4,1,i);
    
    [W,SC,Ep] = Entrena(X,Yd,W0,tasa_ep,MaxEp,TolEr,i);
    vec_W(:,:,1,i) = W; 
    fprintf('Porcentaje de aciertos en el aprendizaje: %.2f\nEp. utilizadas: %d\n',SC,Ep);
    
end


%% Test
fprintf('\n---- TEST ------\n');
vec_Sc = zeros(1,nro_part);
figure(2);
for i=1:nro_part
    X = DTst(:,1:3,1,i);
    Yd = DTst(:,4,1,i);
    % Llamo a la funcion
    [Sc] = Prueba(X,Yd,W,i+nro_part);
    fprintf('Porcentaje de aciertos en la prueba num %d: %.2f\n',i,Sc);
    vec_Sc(i) = Sc; 
end

fprintf('\n---- RESULTADOS ------ \n');
prom = mean(vec_Sc);
var = var(vec_Sc);
fprintf('Promedio Acierto: %.3f   Varianza: %.3f\n',prom,var);
