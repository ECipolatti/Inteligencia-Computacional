function [er] = perceptron_test(M,w)
    phi = @(z) signo(z);
    [n,m] = size(M);    % n: nro. de filas; m: nro. de columnas
    
    % con el último vector w "aprendido" calculo nuevamente y = phi(z)
    % y mido el error contra el valor deseado. se cuentan la cantidad
    % de aciertos y se saca un porcentaje (para usar como corte)
    e = 0;
    for i = 1 : n
        z = dot([-1 M(i,1:m-1)],w);
        y = phi(z);
        yd = M(i,m);
        if yd ~= y
            e = e+1;
        end
    end
    er = e/n*100;   % er: tasa de error: nro. errados/total

end
