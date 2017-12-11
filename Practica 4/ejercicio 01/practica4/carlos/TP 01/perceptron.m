function [y,w] = perceptron(x0,w0,lf,yd,phi)
    % Perceptrón simple
    x = [-1 x0];
    z = dot(x,w0);
    y = phi(z);
    e = yd - y;
    w = w0 + lf*e*x;
end

