%% Funcion de prueba del Ejercicio 2

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [Sc] = Test(X,Yd,W,u)

    n = size(X,1);
    X = [-ones(n,1),X];
    Er = 0;
    for i = 1:n
        Y = signc(X(i,:)*W');
        if Y ~= Yd(i)
            Er = Er + 1;
        end
    end
    Er = (Er*100)/n;
    Sc = 100 - Er;
    subplot(3,2,u);
    Graph2(W,X,Yd,u);

end