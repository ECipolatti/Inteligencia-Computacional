%% Funcion graficadota - Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [] = Grafica(W,X,Yd)

    n = size(X,1);
    k = X(Yd(:)>0,:);
    scatter(k(:,2),k(:,3),2,'g');
    hold on
    r = X(Yd(:)<0,:);
    scatter(r(:,2),r(:,3),2,'b');
    plot([-1.1:0.1:1.1],W(1)/W(3)-W(2)/W(3)*[-1.1:0.1:1.1],'r','LineWidth',3); %Recta
    hold off;
    axis([-1.2,1.2,-1.2,1.2]);
    title('Mapa de puntos - Recta solución')
    pause(0.01);

end