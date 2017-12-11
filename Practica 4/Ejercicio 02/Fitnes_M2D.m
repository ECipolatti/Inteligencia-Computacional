function [ Mat_Fitnes ] = Fitnes_M2D( Particulas, type_fitnes )
    [n, m]= size(Particulas);
    Mat_Fitnes = zeros(n,1);
    for i = 1 : n
            Mat_Fitnes(i) = Fitnes2D(Particulas(i, :), type_fitnes);
    end
end

