clear all; close all;

prompt = 'Redefinir parámetros [1]-SI; [~]-NO: '; op = input(prompt);
if op == 1
    prompt = 'Tasa de aprendizaje: '; lf = input(prompt);
    prompt = 'Cantidad de épocas: ';  nep = input(prompt);
    prompt = 'Tolerancia de error: '; tol = input(prompt);
else
    lf = 0.0000095; nep = 100; tol = 5;
end

prompt = 'Visualizar entrenamiento: [1]-OR; [2]-XOR; [~]-Salir: ';
op = input(prompt);

% para el caso OR
if op == 1
    M = csvread('datos/OR_trn.csv'); desc = 'Entrenamiento OR';
    [ert,nep,w] = perceptron_train(M,desc,lf,nep,tol,1);
    
    % prueba aleatoria con datos de prueba
    M = csvread('datos/OR_tst.csv'); er = perceptron_test(M,w);
    desc = sprintf('Test OR - Tasa de error: %0.2f%%',er);
    figure('Name',desc);
    graph2D(w,M,desc);

end

% para el caso XOR
if op == 2
    M = csvread('datos/XOR_trn.csv'); desc = 'Entrenamiento XOR';
    [ert,nep,w] = perceptron_train(M,desc,lf,nep,tol,1);
    
    % prueba aleatoria con datos de prueba
    M = csvread('datos/XOR_tst.csv');
    er = perceptron_test(M,w);
    desc = sprintf('Test XOR - Tasa de error: %0.2f%%',er);
    figure('Name',desc);
    graph2D(w,M,desc);
end
