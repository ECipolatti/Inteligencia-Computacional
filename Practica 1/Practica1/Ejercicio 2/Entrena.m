%% Funcion de aprendizaje del Ejercicio 2

% X: matriz de patrones por fila
% Yd: vector de salidas esperadas
% W: vector fila de pesos
% tasa_ap: Tasa de aprendizaje
% MaxEp: Limite de Epocas a evaluar
% TolEr: Tolerancia de error

function [W,Sc,Ep] = Entrena (X,Yd,W,tasa_ap,MaxEp,TolEr,u)

    n = size(X,1);
    X = [-ones(n,1),X]; % X extendida con -1
    Er = 100;
    Sc = 100;
    Ep = 0;
    while (Ep < MaxEp) && (TolEr < Er)
        for i = 1:n
            Y = signc(X(i,:)*W');
            W = W + (tasa_ap/2)*(Yd(i) - Y)*X(i,:);
        end
        %subplot(3,2,u);
        figure(u);
        titulo=1;
        Grafica(W,X,Yd,titulo);
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
        fprintf('Sc: %.2f - Ep: %d\n',Sc,Ep);
    end
    
end