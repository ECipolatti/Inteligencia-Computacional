clear all; close all;

%% Ejercicio 1
type = 'G';
X = (-20 : .001 : 20);
x = -10;
A = [1 2];
muA = membership(type, A, x);
Graficar(type, A, X);
hold on
plot(x, muA, '*');

%% Ejercicio 2
type = 'T';
X = (-20 : .001 : 20);
MT = [-20 -20 -10 -5; -10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
MG = [-10 2; -9 1; 10 .5; 5 .2];
Graficar(type, MT, X);

%% Ejercicio 3
X = (-20 : .001 : 20);
MT = [-20 -20 -10 -5; -10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
MG = [1 1; 2 1; 0.6 1; 5 1; 1 1; 7 1; 4 1];
type = 'G';
val = 3;
muA = vecMember(type, MG, val);
Graficar(type, MG, X);
hold on
for i=1 : length(muA)
    plot(val, muA(i), '*');
end

%% Ejercicio 4
X = -20 : 0.001 : 20;
type = 'T';
ST = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];
SG = [1 1; 2 1; 0.6 1; 5 1; 3 1; 7 1; 2.5 1];
act = [0; 0.7; 0.3; 0; 0; 0; 0]; % El vector a va como columna
y_sal = defuzzification(type, ST, act);
Graficar_defu(type, ST, X, act);
hold on;
line([y_sal y_sal],[0 1]);

%% Ejercicio 5
X = -20 : 0.001 : 20;
type = 'T';
M = [-20 -20 -10 -5; -10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
S = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];
r = [1; 2; 3; 4; 5; 6; 7];
val = -7;
muA = vecMember(type, M, val);

subplot(3,1,1);
Graficar(type, M, X);
title('Conjuntos de Entrada');
hold on
for i=1 : length(muA)
    plot(val, muA(i), '*');
end
subplot(3,1,2);
Graficar(type,S,X);
title('Conjuntos de Salida');

muX = vecMember(type, M, val);
act = Ordena(muX', r);
y_sal = defuzzification(type, S, act);

subplot(3,1,3);
Graficar_defu(type, S, X, act);
title('Salida');
hold on;
line([y_sal y_sal],[0 1]);

%% Ejercicio 6
X_graf = -20 : 0.001 : 20 ;
X = (-20 : 1 : 20);
[~, n] = size(X);
MT = [-20 -20 -10 -5; -10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
MG = [1 1; 2 1; 0.6 1; 5 1; 3 1; 7 1; 4 1];
ST = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];
SG = [1 1; 2 1; 0.6 1; 5 1; 3 1; 7 1; 2.5 1];
r = [7;6;5;4;3;2;1];
y_sal = zeros(1,n);

type = 'T';
M = MT;
S = ST;

for i=1:n
    subplot(3,1,1);
    Graficar(type, M, X_graf);
    title('Conjuntos de Entrada');
    hold on
    val = X(i);
    muA = vecMember(type, M, val);
    for j=1 : length(muA)
        plot(val, muA(j), '*');
    end
    
    subplot(3,1,2);
    Graficar(type,S,X_graf);
    title('Conjuntos de Salida');
   
    subplot(3,1,3);
    
    muX = vecMember(type, M, X(i));
    act = Ordena(muX' ,  r);
    y_sal(i) = defuzzification(type, S, act);
    
    Graficar_defu(type, S, X_graf, act);
    title('Salida');
    hold on;
    line([y_sal(i) y_sal(i)],[0 1]);
    pause(0.1); 
    if i<n
     clf;
    end
end
figure
plot(X,y_sal);
%close all

%% Ejercicio 7
X_graf = -20 : 0.001 : 20 ;
M1 = [-20 -20 -10 -5; -10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
M2 = [-20 -20 -10 -5; -10 -5 -4 -2; -4 -2 -1 0; -1 0 0 1; 0 1 2 4; 2 4 5 10; 5 10 20 20];

S1 = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];
S2 = [-7 -5 -5 -4; -5 -4 -4 -3; -4 -3 -3 0; -3 0 0 3; 0 3 3 4; 3 4 4 5; 4 5 5 7];

r = [1; 2; 3; 4; 5; 6; 7];

type = 'T';
M = M2;
S = S2;

ti = 15;
g = 40/41;
a = 40/41;
t_ref = 15;
t_ant = 15;
to = 15;

t = zeros(1,200);
qv = zeros(1,200);

for i = 1:200
    er =  t_ref - to;
    if i < 31
        muX = vecMember(type, M, er);
        act = Ordena(muX' ,  r);
        q = defuzzification(type, S, act);
    else
        muX = vecMember(type, M, er);
        act = Ordena(muX' ,  r);
        q = defuzzification(type, S, act);
        t_ref = 25;
    end
    to = ti + g*q + a*(t_ant - ti);
    t_ant = to;
    t(i) = to;
    qv(i) = q;
end
subplot(2,2,1)
Graficar(type,M,X_graf);
title('Conjuntos de Entrada');
subplot(2,2,2)
Graficar(type,S,X_graf);
title('Conjuntos de Salida');
subplot(2,2,3);
plot(t,'b');
title('Temperatura');
xlabel('x');
ylabel('y');
subplot(2,2,4);
plot(qv,'r');
title('Flujo q');
xlabel('x');
ylabel('y');
