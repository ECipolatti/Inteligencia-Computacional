function [ Vec_Fitnes, Maximo, ind ] = Fitnes_Matrix( Fenotipos, type_fitnes)
    [n, ~]= size(Fenotipos);
    Vec_Fitnes = zeros(n,1);
    for i=1:n
        Vec_Fitnes(i) = Fitnes(Fenotipos(i),0,type_fitnes);
    end
    [Maximo, ind] = max(Vec_Fitnes);
end

