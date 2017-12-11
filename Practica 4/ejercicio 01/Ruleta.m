function [ S ] = Ruleta(num_ganadores, Fenotipos, type_fitnes)
    S = zeros(num_ganadores,1);
    % Ordeno Segun Fitnes
    [Vec_Fitnes, ~, ~] = Fitnes_Matrix(Fenotipos, type_fitnes);
    [Vec_F_ord, Indices] = sort(Vec_Fitnes);
    
    Fitnes = Vec_F_ord + abs(min(Vec_F_ord)); %Hago todos los valores positivos
    sumf = 1/sum(Fitnes);
    P = Fitnes.*sumf;
    
    for i=1:num_ganadores
        dado = rand();
        %ind_ganador = Indices(buscar(P, dado));
        S(i) = Fenotipos(Indices(buscar(P', dado)));
    end

end

