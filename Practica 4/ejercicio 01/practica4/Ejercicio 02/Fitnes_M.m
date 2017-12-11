function [ Vec_Fitnes ] = Fitnes_Matrix( Particulas, type_fitnes )
    [n, ~]= size(Particulas);
    Vec_Fitnes = zeros(n,1);
    for i=1:n
        Vec_Fitnes(i) = Fitnes(Particulas(i),0,type_fitnes);
    end
end

