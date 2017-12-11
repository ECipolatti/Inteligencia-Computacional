clear all; close all;

prompt = 'Redefinir parámetros [1]-SI; [~]-NO: '; op = input(prompt);
if op == 1
    prompt = 'Tasa de aprendizaje: '; lf = input(prompt);
    prompt = 'Cantidad de épocas: ';  nep = input(prompt);
    prompt = 'Tolerancia de error: '; tol = input(prompt);
    prompt = 'Cantidad de particiones: '; k = input(prompt);
    prompt = 'Gráficas de entrenamiento [1]- Sí; [~]- No: '; sg = input(prompt);
else
    lf = 0.0001; nep = 5; tol = 15; k = 5; sg = 1;
end
prompt = 'Método: [1]-K-folding; [2]-Cross validation; [~]-Salir: ';
op = input(prompt);

if op == 2
    prompt = 'Ratio: '; ratio = input(prompt);
end

if op ~= 1 && op ~= 2
    return;
end

%% spheres1d10.csv
file = 'datos/spheres1d10.csv'; desc = 'Test spheres1d10.csv';
er1d10 = ones(1,k); % vector de error para cada iteración

if op == 1
    [training,test] = partition(file,k);
elseif op == 2
    [training,test] = partition(file,k,ratio);
end

for i = 1 : k
	[~,~,w] = perceptron_train(squeeze(training(i,:,:)),desc,lf,nep,tol,sg);
    er1d10(i) = perceptron_test(squeeze(test(i,:,:)),w);
end

mean1d10 = mean(er1d10);
stdev1d10 = std(er1d10);

%% spheres2d10.csv
file = 'datos/spheres2d10.csv'; desc = 'Test spheres2d10.csv';
er2d10 = ones(1,k); % vector de error para cada iteración

if op == 1
    [training,test] = partition(file,k);
elseif op == 2
    [training,test] = partition(file,k,ratio);
end

for i = 1 : k
	[~,~,w] = perceptron_train(squeeze(training(i,:,:)),desc,lf,nep,tol,sg);
    er2d10(i) = perceptron_test(squeeze(test(i,:,:)),w);
end

mean2d10 = mean(er2d10);
stdev2d10 = std(er2d10);

%% spheres2d50.csv
file = 'datos/spheres2d50.csv'; desc = 'Test spheres2d50.csv';
er2d50 = ones(1,k); % vector de error para cada iteración

if op == 1
    [training,test] = partition(file,k);
elseif op == 2
    [training,test] = partition(file,k,ratio);
end

for i = 1 : k
	[~,~,w] = perceptron_train(squeeze(training(i,:,:)),desc,lf,nep,tol,sg);
    er2d50(i) = perceptron_test(squeeze(test(i,:,:)),w);
end

mean2d50 = mean(er2d50);
stdev2d50 = std(er2d50);

%% spheres2d70.csv
file = 'datos/spheres2d70.csv'; desc = 'Test spheres2d70.csv';
er2d70 = ones(1,k); % vector de error para cada iteración

if op == 1
    [training,test] = partition(file,k);
elseif op == 2
    [training,test] = partition(file,k,ratio);
end

for i = 1 : k
	[~,~,w] = perceptron_train(squeeze(training(i,:,:)),desc,lf,nep,tol,sg);
    er2d70(i) = perceptron_test(squeeze(test(i,:,:)),w);
end

mean2d70 = mean(er2d70);
stdev2d70 = std(er2d70);

%% resultados
MEAN = [mean1d10;mean2d10;mean2d50;mean2d70];
STDEV = [stdev1d10;stdev2d10;stdev2d50;stdev2d70];
labels = {'spheres1d10';'spheres2d10';'spheres2d50';'spheres2d70'};
table(MEAN,STDEV,'RowNames',labels)