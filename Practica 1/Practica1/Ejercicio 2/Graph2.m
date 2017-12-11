%% Grafica del Ejercicio 2

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [] = Graph2(W,X,Yd,u)

    n = size(X,1);
    k = X(Yd(:)>0,:);
    scatter3(k(:,2),k(:,3),k(:,4),'k');
    hold on
    r = X(Yd(:)<0,:);
    scatter(r(:,2),r(:,3),'r');
    [x1,x2]=meshgrid(-2:0.2:2);
    x3= W(1)/W(4) - W(2)/W(4)*x1 - W(3)/W(4)*x2;
    surf(x1,x2,x3);
    axis equal;
    axis([-2 2 -2 2 -2 2])
    xlabel('X1');
    ylabel('X2');
    zlabel('X3');
    title(strcat('Particion: ',int2str(u)));

    hold off;
    pause(0.25);
    
  
end