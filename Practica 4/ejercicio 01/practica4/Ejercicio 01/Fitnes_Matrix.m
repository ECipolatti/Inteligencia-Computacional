function [ Vec_Fitnes ] = Fitnes_Matrix( Genotipos, type_fitnes, tasa )
    [n, ~]= size(Genotipos);
    Vec_Fitnes = zeros(n,1);
    [ Fenotipos ] = Decodificacion(Genotipos);
    for i=1:n
        Vec_Fitnes(i) = Fitnes(Fenotipos(i),0,type_fitnes, tasa);
    end
end

