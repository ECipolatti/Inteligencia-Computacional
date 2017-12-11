function [ y ] = sigmoid( x,c )
    if nargin == 1
        y = 2./(1+exp(-1*x)) - 1;
    elseif nargin == 2
        y = 2./(1+exp(-c*x)) - 1;
    end

end

