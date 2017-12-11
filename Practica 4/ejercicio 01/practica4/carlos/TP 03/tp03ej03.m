close all; clear all;

% parámetros para conjuntos con membresía trapezoidal/triangular
Mt = [-20 -20 -10 -5;-10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
% parámetros para conjuntos con membresía gaussiana
Mg = [-3 1; -2 0.75; -1 0.5; 0 0.25; 1 0.5; 2 0.75; 3 1];
% valor para calcular/graficar
x = 1;

figure;
hold on;
[~] = graphmemb(Mt,'t');
mut = membvec(Mt,'t',x);
scatter(x*ones(size(Mt,1),1),mut,'*r');
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('\mu(x)','FontSize',12,'FontWeight','bold');
title('Conjuntos con membresía de tipo Trapezoidal','FontSize',12,'FontWeight','bold');
hold off;


figure;
hold on;
[~] = graphmemb(Mg,'g');
mug = membvec(Mg,'g',x);
scatter(x*ones(size(Mg,1),1),mug,'*r');
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('\mu(x)','FontSize',12,'FontWeight','bold');
title('Conjuntos con membresía de tipo Gaussiana','FontSize',12,'FontWeight','bold');
hold off;