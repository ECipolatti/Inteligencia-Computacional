function [ y_sal ] = defuzzification( type, S, a )
    [n, m] = size(S);
    if (type == 'G')
        y_cg = S(:,1);
        A = S(:,2) * sqrt((2*pi));
    else
        A = zeros(n,1);
        y_cg = zeros(n,1);
        for i = 1 : n
            B = S(i, end) - S(i, 1);
            b = S(i, 3) - S(i, 2);
            h = 1;
            A(i) = (B + b)*h / 2;
            A1 = (S(i, 2) - S(i, 1))*h/2;
            A2 = (S(i, 3) - S(i, 2))*h;
            A3 = (S(i, 4) - S(i, 3))*h/2;
            cg1 = (S(i, 2) - (S(i, 2) - S(i, 1))/3) * A1;
            cg2 = (S(i, 2) + (S(i, 3) - S(i, 2))/2) * A2;
            cg3 = (S(i, 3) + (S(i, 4) - S(i, 3))/3) * A3;
            
            y_cg(i) = (cg1 + cg2 + cg3) / A(i);
        end
    end
    y_sal = (y_cg' * (A .* a)) / (A' * a);
end

