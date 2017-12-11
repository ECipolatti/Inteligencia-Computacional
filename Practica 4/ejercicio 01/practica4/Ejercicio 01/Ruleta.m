function [ seleccionados ] = Ruleta(n_selec, Genotipos, type_fitnes, tasa )
    [n, ~]= size(Genotipos);

    % Ordeno Segun Fitnes
    [Vec_Fitnes] = Fitnes_Matrix( Genotipos, type_fitnes, tasa );
    [Vec_F_ord, Indices] = sort(Vec_Fitnes);
    
    prob = 1/sum(abs(Vec_F_ord(1:end)+2*min(Vec_F_ord(1:end))));
    P = Vec_F_ord.*(Vec_F_ord(1:end)*prob);
    
%     for i=1:n_selec
%         dado = rand();
%         for j=1:n-1
%            if dado > 
%         end
%     end
    

    


end

