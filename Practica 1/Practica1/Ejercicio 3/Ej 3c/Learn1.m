%% Función de aprendizaje del Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos
% LrnRt: Tasa de aprendizaje
% MaxEp: Límite de épocas a evaluar
% TolEr: Tolerancia de error

function [W,Sc,Ep] = Learn1 (X,Yd,W,LrnRt,MaxEp,TolEr)

    n = size(X,1);
    X = [-ones(n,1),X];
    Er = 100;
    Sc = 100;
    Ep = 0;
    while Ep < MaxEp && TolEr < Er
        for i = 1:n
            Y = signc(X(i,:)*W');
            W = W + (LrnRt/2)*(Yd(i) - Y)*X(i,:);
        end
        Er = 0;
        for i = 1:n
            Y = signc(X(i,:)*W');
            if Y ~= Yd(i)
                Er = Er + 1;
            end
        end
        Er = (Er*100)/n;
        Sc = 100 - Er;
        Ep = Ep + 1;
        fprintf('Sc: %d - Ep: %d\n',Sc,Ep);
    end
    
end