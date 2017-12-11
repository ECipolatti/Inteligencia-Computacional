function [  ] = Grafica( filename )
    Datos = csvread(filename);
    Prom = Datos(:,1:6);
    Desv = Datos(:,7:end);
    % Graficas Promedios
    Label_Datos = {'Iteraciones','Tiempo','Inter','Intra','Intra/Inter','Ind_DB','Ind_Dunn','Ind_CH'};
    Label_Metodo = {'BallHall','Etiquetado','Forgy','k - means++','Mc Queen','Mc Rae'};
    x = [Prom(1,:); (Prom(2,:)).*100; Prom(3,:); Prom(4,:); Prom(5,:); Prom(6,:); Prom(7,:); Prom(8,:).*0.01];
    bar(x);
    set(gca,'XTickLabel',Label_Datos);
    legend(Label_Metodo,'Location','NorthEastOutside');
    title(filename);
% 
% %     x = [0.7:.1:1.2 1.7:.1:2.2 2.7:.1:3.2 3.7:.1:4.2 4.7:.1:5.2 5.7:.1:6.2 6.7:.1:7.2 7.7:.1:8.2 8.7:.1:9.2]';
% %     y = [Desv(1,:)'; Desv(2,:)'; Desv(3,:)'; Desv(4,:)'; zeros(1,6)'; Desv(5,:)'; Desv(6,:)'; Desv(7,:)'];
%     text(x,y,num2str(y,'%1.1f'),'LineWidth',8,'HorizontalAlignment','center','VerticalAlignment','bottom')   
% %     
end

