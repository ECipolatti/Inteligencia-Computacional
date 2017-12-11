function [dec] = hfloat(bin)
    % float de half precision
    n = 1;
    f = 1;                              % mantisa
    for i = 7 : 16
        f = f + bin(i)*2^-n;
        n = n+1;
    end
    
    e = bi2de(bin(2:6),'left-msb')-15;	% exponente (se resta el bias)
    s = bin(1);                         % signo
    dec = (-1)^s*f*2^e;                 % número decimal


end

