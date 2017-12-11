%% Funcion de entrenamiento - Ejercicio 1

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos
% Taza_Ap: Tasa de aprendizaje
% MaxEp: Limite epocas
% TolEr: Tolerancia de error

function [W,Er,Ep,vec_Er,Y_sal] = Entrena (X,Yd,W,Tasa_Ap,MaxEp,TolEr)
    n = size(X,1);
    Y_sal = zeros(n,1);
    vec_Er = zeros(MaxEp,1);
    X = [-ones(n,1),X];
    Er = 100;
    Ep = 0;
    while (Ep < MaxEp) && (TolEr < Er)
        for i = 1:n
            Y =(X(i,:)*W');
            W = W + (Tasa_Ap/2)*(Yd(i) - Y)*X(i,:);
        end
        Er = 0;
        for i = 1:n
            Y = X(i,:)*W';
            Y_sal(i) = Y;
            if signc(Y) ~= Yd(i)
                Er = Er + 1;
            end
        end
        Er = (Er*100)/n;
        Ep = Ep + 1;
        vec_Er(Ep) = Er;
       % fprintf('Sc: %.2f - Ep: %d\n',Sc,Ep);
    end
end