%% Función de prueba del Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [Sc, Yo] = Test1(X,Yd,W)

    n = size(X,1);
    X = [-ones(n,1),X];
    Yo = zeros(n,1);
    Er = 0;
    for i = 1:n
        Y = signc(X(i,:)*W');
        Yo(i) = Y;
        if Y ~= Yd(i)
            Er = Er + 1;
        end
    end
    Er = (Er*100)/n;
    Sc = 100 - Er;

end