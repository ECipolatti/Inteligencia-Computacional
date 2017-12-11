%% Grafica del Ejercicio 2

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [] = Grafica(W,X,Yd,titulo)

    n = size(X,1);
    k = X(Yd(:)>0,:);
    scatter3(k(:,2),k(:,3),k(:,4),'r');
    hold on
    r = X(Yd(:)<0,:);
    scatter3(r(:,2),r(:,3),r(:,4),'k');
    [x1,x2]=meshgrid(-2:0.2:2);
    x3= W(1)/W(4) - W(2)/W(4)*x1 - W(3)/W(4)*x2; % plano
    surf(x1,x2,x3);
    %axis equal;
    axis([-2 2 -2 2 -2 2])
    xlabel('X1');
    ylabel('X2');
    zlabel('X3');
    if titulo == 1
        title('Entrenamiento');
    else
        title('Prueba');
    end
    hold off;
    pause(0.01);
    
  
end