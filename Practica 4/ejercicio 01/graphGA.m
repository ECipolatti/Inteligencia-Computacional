function [] = graphGA(f,ff,range,fen,fitness,m)
    if length(range) == 2
        pause(0.25);
        clf;
        
        x = range(1):0.1:range(2);
        subplot(2,1,1);
        hold on;
        plot(x,f(x));
        scatter(fen,f(fen),600,'.');
        scatter(fen(m),f(fen(m)),600,'or');
        hold off;
        title('Cromosomas sobre curva f(x)','FontSize',14,'FontWeight','bold');
        xlabel('x','FontSize',14,'FontWeight','bold');
        ylabel('f(x)','FontSize',14,'FontWeight','bold');
        
        subplot(2,1,2);
        hold on;
        plot(x,ff(x));
        scatter(fen,fitness,600,'.');
        scatter(fen(m),ff(fen(m)),600,'or');
        hold off;
        title('Fitness de cromosomas','FontSize',14,'FontWeight','bold');
        xlabel('x','FontSize',14,'FontWeight','bold');
        ylabel('fitness(x)','FontSize',14,'FontWeight','bold');
        drawnow;
    elseif length(range) == 4
        pause(0.25);
        clf;        
        subplot(1,2,1)
        hold on;
        scatter3(fen(:,1),fen(:,2),f(fen(:,1),fen(:,2)),600,'.m');
        scatter3(fen(m,1),fen(m,2),f(fen(m,1),fen(m,2)),600,[1 0 0]);
        [x2,y2] = meshgrid(range(1):1:range(2),range(3):5:range(4));
        mesh(x2,y2,f(x2,y2));
        view(3); grid on;
        hold off;
        title('Cromosomas sobre superficie f(x,y)','FontSize',14,'FontWeight','bold');
        xlabel('x','FontSize',14,'FontWeight','bold');
        ylabel('y','FontSize',14,'FontWeight','bold');
        zlabel('f(x,y)','FontSize',14,'FontWeight','bold');
        
        subplot(1,2,2);
        hold on;
        scatter3(fen(:,1),fen(:,2),fitness,600,'.m');
        scatter3(fen(m,1),fen(m,2),ff(fen(m,1),fen(m,2)),600,[1 0 0]);
        [x2,y2] = meshgrid(range(1):1:range(2),range(3):5:range(4));
        mesh(x2,y2,ff(x2,y2));
        view(3); grid on;
        hold off;
        title('Fitness de cromosomas','FontSize',14,'FontWeight','bold');
        xlabel('x','FontSize',14,'FontWeight','bold');
        ylabel('y','FontSize',14,'FontWeight','bold');
        zlabel('f(x,y)','FontSize',14,'FontWeight','bold');
        drawnow;
    end
end

