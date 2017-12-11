close all; clear all;

% parámetros para conjuntos con membresía trapezoidal/triangular
Mt = [-20 -20 -10 -5;-10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
figure;
[~] = graphmemb(Mt,'t');
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('\mu(x)','FontSize',12,'FontWeight','bold');
title('Conjuntos con membresía de tipo Trapezoidal','FontSize',12,'FontWeight','bold');

% parámetros para conjuntos con membresía gaussiana
Mg = [-10 3.5; -6 3; -3.5 2.5; 0 2; 3.5 2.5; 6 3; 10 3.5];
figure;
[~] = graphmemb(Mg,'g');
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('\mu(x)','FontSize',12,'FontWeight','bold');
title('Conjuntos con membresía de tipo Gaussiana','FontSize',12,'FontWeight','bold');