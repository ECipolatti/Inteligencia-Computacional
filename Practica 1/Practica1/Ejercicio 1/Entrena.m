%% Funcion de entrenamiento - Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos
% Taza_Ap: Tasa de aprendizaje
% MaxEp: Limite epocas
% TolEr: Tolerancia de error

function [W,Sc,Ep,vec_Er] = Entrena (X,Yd,W,Tasa_Ap,MaxEp,TolEr)
    
    vec_Er = zeros(MaxEp,1);
    n = size(X,1);
    X = [-ones(n,1),X];
    Er = 100;
    Sc = 100;
    Ep = 0;
    while (Ep < MaxEp) && (TolEr < Er)
        for i = 1:n
            Y = signc(X(i,:)*W');
            W = W + (Tasa_Ap/2)*(Yd(i) - Y)*X(i,:);
        end
        figure(1);
        Grafica(W,X,Yd);
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
        vec_Er(Ep) = Er;
        fprintf('Sc: %.2f - Ep: %d\n',Sc,Ep);
    end
    
end