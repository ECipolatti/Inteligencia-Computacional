clear all; close all;

% GRADIENTE DESCENDIENTE
syms x y;

%% 1-a)
f = -x.*sin(sqrt(abs(x)));
range = [-512,512];
maxit = 200;
a = 1;                      % prioriza el valor de la derivada
b = 1;                      % prioriza la diferencia de las derivadas
tol = 0.01;                 % se busca obtener un mínimo con determinada tolerancia
% [n,x] = descgrad(f,range,maxit,a,b,tol);

%% 1-b)
f = x+5*sin(3*x)+8*cos(5*x);
range = [0,20];
a = 0.02;
b = 0.01;
[n,x] = descgrad(f,range,maxit,a,b,tol);

%% 1-c)
f = (x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);
range = [-100 100 -100 100];
a = 0.1;
b = 0.2;
% [n,x] = descgrad(f,range,maxit,a,b,tol);