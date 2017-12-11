close all; clear all;

% ALGORITMO EVOLUTIVO

%% 1-a)
M = 100;                        % tamaño de la población
N = 10;                         % cantidad de genes por cromosoma
mrate = 0.05;                   % tasa de mutaciones
prate = 0.5;                    % tasa de padres
crprob = 0.8;                   % probabilidad de que haya cruzas
gap = 0.1;                      % brecha generacional
maxit = 1000;                   % máximo de iteraciones
idle = 500;                      % tolerancia de iteraciones sin mejoras en la población
k = 2;                          % cantidad de individuos seleccionados para competencia
method = 2;                     % método de selección (1: Ventanas; 2: Competencia)

range = [-512 512];             % rango de definición del problema
f = @(x) -x.*sin(sqrt(abs(x))); % función a hallar el mínimo global
ff = @(x) x.*sin(sqrt(abs(x))); % función de aptitud correspondiente

% [n,fen] = genalg(M,N,mrate,prate,crprob,gap,maxit,idle,range,method,k,f,ff);

%% 1-b)

range = [0 20];                 % rango de definición del problema
f= @(x) (x+5*sin(3*x)+8*cos(5*x));
ff=  @(x) -(x+5*sin(3*x)+8*cos(5*x));

% [n,fen] = genalg(M,N,mrate,prate,crprob,gap,maxit,idle,range,method,k,f,ff);

%% 1-c)
range =[-100 100 -100 100];
M = 200;
N = 80;
f = @(x,y) (x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);
ff= @(x,y)-(x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);

[n,fen] = genalg(M,N,mrate,prate,crprob,gap,maxit,idle,range,method,k,f,ff);

