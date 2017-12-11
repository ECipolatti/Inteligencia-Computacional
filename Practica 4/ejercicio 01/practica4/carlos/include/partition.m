function [training,test] = partition(file,k,ratio)
    % esta función es sólo un wrapper para elegir entre los posibles
    % métodos. con k se establecen la cantidad de arreglos de matrices de 
    % datos que se devuelven con el método y además sirve para k-folding 
    % como parámetro del método
    
    % primero un par de verificaciones para ver si los parámetros de
    % entrada producirán salidas coherentes
    if nargin < 3 
        if k < 2
            error('k debe ser mayor o igual a cero');
        else
            [training,test] = kfold(file,k);
        end
    elseif nargin == 3
        if ratio < 0 || ratio > 1
            error('ratio fuera de rango: [0,1]');
        else
            [training,test] = crossval(file,k,ratio);
        end
    end
end