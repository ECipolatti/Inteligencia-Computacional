function [ val_fitnes ] = Fitnes( val_x, val_y, type_fitnes, tasa )

    switch type_fitnes
        case 1
            val_fitnes = -val_x*sin(sqrt(abs(val_x)));
        case 2
            val_fitnes = -val_x + 5*sin(3*val_x) + 8*cos(5*val_x);
        case 3
            val_fitnes = ((val_x^2 + val_y^2)^(0.25))*((sin(50*(val_x^2+val_y^2))^2)^0.1+1);
    end
    
end

