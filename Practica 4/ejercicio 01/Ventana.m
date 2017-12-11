function [ S ] = Ventana(fac_reduccion, Fenotipos, type_fitnes)
    [n, ~]= size(Fenotipos);
    total_seleccionados = fix(n/fac_reduccion);
    S = zeros(total_seleccionados,1);
    % Ordeno Segun Fitnes
    [Vec_Fitnes, ~, ~] = Fitnes_Matrix(Fenotipos, type_fitnes);
    [~, Indices] = sort(Vec_Fitnes,'descend');
    
    ventana = n;
    for i=1:total_seleccionados
        ind = randi(ventana); %round(rand()*(ventana-1))+1;
        S(i,:) = Fenotipos(Indices(ind));
        ventana = ventana - fac_reduccion;
    end
end

