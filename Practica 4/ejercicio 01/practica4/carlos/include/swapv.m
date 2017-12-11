function [x] = swapv(x)
    % intercambia 2 valores en formato vector
    aux = x(1);
    x(1) = x(2);
    x(2) = aux;
end