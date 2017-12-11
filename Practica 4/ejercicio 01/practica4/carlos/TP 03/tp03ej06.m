close all; clear all;

Mt = [-20 -20 -10 -5;-10 -5 -5 -2; -5 -2 -2 0; -2 0 0 2; 0 2 2 5; 2 5 5 10; 5 10 20 20];
St = [-7 -5 -5 -3; -5 -3 -3 -1; -3 -1 -1 0; -1 0 0 1; 0 1 1 3; 1 3 3 5; 3 5 5 7];

Mg = [-15 3.5; -5 1.5; -2 0.75; 0 0.5; 2 0.75; 5 1.5; 15 3.5];
Sg = [-5 0.75; -3 0.75; -1.5 0.5; 0 0.5; 1.5 0.5; 3 0.75; 5 0.75];

figure;
subplot(3,1,1);
[~] = graphmemb(Mt,'t');
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('y','FontSize',12,'FontWeight','bold');
title('Conjuntos de Entrada con membresía de tipo Trapezoidal','FontSize',12,'FontWeight','bold');
% subplot(2,2,3);
% [~] = graphmemb(Mg,'g',[-20,20]);
% xlabel('x','FontSize',12,'FontWeight','bold');
% ylabel('y','FontSize',12,'FontWeight','bold');
% title('Conjuntos de Entrada membresía de tipo Gaussiana','FontSize',12,'FontWeight','bold');

subplot(3,1,2);
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('y','FontSize',12,'FontWeight','bold');
[~] = graphmemb(St,'t');
title('Conjuntos de Salida con membresía de tipo Trapezoidal','FontSize',12,'FontWeight','bold');

% subplot(2,2,4);
% [~] = graphmemb(Sg,'g',[-7,7]);
% xlabel('x','FontSize',12,'FontWeight','bold');
% ylabel('y','FontSize',12,'FontWeight','bold');
% title('Conjuntos de Salida con membresía de tipo Gaussiana','FontSize',12,'FontWeight','bold');

x = (-20:1:20-1).';
N = length(x);
yt = zeros(N,1);
yg = zeros(N,1);
r = randperm(7);

for i = 1 : N
    yt(i) = fuzzmap(Mt,'t',St,'t',r,x(i));
    yg(i) = fuzzmap(Mg,'g',Sg,'g',r,x(i));
end

subplot(3,1,3);
plot(x,yt);
xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('y','FontSize',12,'FontWeight','bold');
title('Conjuntos con membresía de tipo Trapezoidal','FontSize',12,'FontWeight','bold');

% subplot(2,1,2);
% plot(x,yg);
% xlabel('x','FontSize',12,'FontWeight','bold');
% ylabel('y','FontSize',12,'FontWeight','bold');
% title('Conjuntos con membresía de tipo Gaussiana','FontSize',12,'FontWeight','bold');