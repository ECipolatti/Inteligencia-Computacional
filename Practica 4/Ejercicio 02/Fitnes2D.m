function [ val_fitnes ] = Fitnes2D( Particula, type_fitnes )
    if (type_fitnes == 3)
        val_fitnes = ((Particula(1)^2 + Particula(2)^2)^(0.25)) * ...
                ((sin(50 * (Particula(1)^2 + Particula(2)^2))^2)^0.1 + 1);
    end
end

