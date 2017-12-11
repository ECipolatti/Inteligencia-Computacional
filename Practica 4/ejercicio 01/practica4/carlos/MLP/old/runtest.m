clear all; close all;
addpath('../include')

% fd = csvread('clouds2.csv');
% fd = fd(randperm(size(fd,1)),:);
% [train_data,test_data] = validation(fd,0.2);    % guardo una cantidad de datos sólo de prueba

NTrain = 10000; % Training samples
NTest = 5000; % Testing samples

[train_data, test_data] = readMNISTDataset ('train-images.idx3-ubyte', ...
    'train-labels.idx1-ubyte', ...
    't10k-images.idx3-ubyte', ...
    't10k-labels.idx1-ubyte',...
    NTrain, NTest);

n_in = 400; % cantidad de entradas (definido por el usuario)
% n_out = size(train_data,2) - n_in;  % cantidad de salidas (total de columnas
%                                     % menos la cantidad de entradas)
n_out = 10;
% si n_ouputs no es entero mayor o igual a 1 no se puede continuar
if (n_out < 1)
    error('Cantidad insuficiente de salidas');
end

ki = 10;
kj = ki;
tol = 95;

stats = zeros(ki*kj,7);
c = 1;
flag = 0;
l1 = 10;
l2 = 10;
l3 = n_out;

% RN = [l1 l2 l3]';   % definición de la arquitectura de la red
% stats(c,1:3) = RN;
% [A,stats(c,end)] = mlp_kfold(train_data,test_data,RN,n_in,n_out,tol);
% stats(c,4:end-1) = A(1,2:end);

for i = 1 : ki
    l2 = [round(l1/2) l1 2*l1];
    for j = 1 : 3
       RN = [l1 l2(j) l3]';   % definición de la arquitectura de la red
       stats(c,1:3) = RN;
       [A,stats(c,end)] = mlp_kfold(train_data,test_data,RN,n_in,n_out,tol);
       stats(c,4:end-1) = A(1,2:end);
       if stats(c,5) > tol
           flag = 1;
           break;
       end
       c = c + 1;
   end
   if flag
       break;
   end
   l1 = round(l1*1.5);
   l2 = round(l2*1.5);
end

% for i = 1 : ki
%    l1 = n_in^i;
%    l2 = [round(l1/2) l1 2*l1];
%    for j = 1 : 3
%        RN = [l1 l2(j) l3]';   % definición de la arquitectura de la red
%        stats(c,1:3) = RN;
%        [A,stats(c,end)] = mlp_kfold(train_data,test_data,RN,n_in,n_out,tol);
%        stats(c,4:end-1) = A(1,2:end);
%        if stats(c,5) > tol
%            flag = 1;
%            break;
%        end
%        c = c + 1;
%    end
%    if flag
%        break;
%    end
% end

fprintf('Tiempo total: %.2f seg \n',sum(stats(:,7)));