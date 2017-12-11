close all; clear all;

a = [0 0.7 0.3 0 0 0 0];

% parámetros para conjuntos con membresía trapezoidal/triangular
St = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];
yt = defuzzify(St,'t',a);
figure;
subplot(2,1,1);
[~] = graphmemb(St,'t');

% parámetros para conjuntos con membresía gaussiana
Sg = [-5 0.75; -3 0.75; -1.5 0.5; 0 0.5; 1.5 0.5; 3 0.75; 5 0.75];
yg = defuzzify(Sg,'g',a);
subplot(2,1,2);
[~] = graphmemb(Sg,'g',[-7 7]);
