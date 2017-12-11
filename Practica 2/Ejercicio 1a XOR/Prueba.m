%% Funcion de prueba - Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos

function [Er, Y_sal] = Prueba(X,Yd,W)
     Y_sal = zeros(size(X,1),1);
    n = size(X,1);
    X = [-ones(n,1),X];
    Er = 0;
    for i = 1:n
        Y = signc(X(i,:)*W');
         Y_sal(i) = Y;
        if Y ~= Yd(i)
            Er = Er + 1;
        end
    end
    Er = (Er*100)/n;
end