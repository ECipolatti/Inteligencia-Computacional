function [ Promedios, Desvios ] = Resultados( Iteraciones, Tiempo, Inter, Intra, Ind_DB, Ind_Dunn, Ind_CH)
    % Iteraciones | Tiempo | Inter | Intra | Intra/Inter | Ind_DB | Ind_Dunn | Ind_CH
    Promedios = zeros(8,6);
    Desvios = zeros(8,6);
    
    Promedios(1,:) = ceil(mean(Iteraciones));
    Desvios(1,:) = std(Iteraciones,0,1);
    Promedios(2,:) = mean(Tiempo);
    Desvios(2,:) = std(Tiempo,0,1);
    Promedios(3,:) = mean(Inter);
    Desvios(3,:) = std(Inter,0,1);
    Promedios(4,:) = mean(Intra);
    Desvios(4,:) = std(Intra,0,1);
    Promedios(5,:) = Promedios(4,:)./Promedios(3,:);
    Promedios(6,:) = mean(Ind_DB);
    Desvios(5,:) = std(Ind_DB,0,1);
    Promedios(7,:) = mean(Ind_Dunn);
    Desvios(6,:) = std(Ind_Dunn,0,1);
    Promedios(8,:) = mean(Ind_CH);
    Desvios(7,:) = std(Ind_CH,0,1);
end

