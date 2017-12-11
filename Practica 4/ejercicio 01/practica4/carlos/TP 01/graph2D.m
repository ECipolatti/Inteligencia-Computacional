function [] = graph2D(w,M,desc)
    x1 = linspace(-2.1,2.1);
    x2 = w(1)/w(3) - w(2)/w(3)*x1; % armo la recta a partir de la fórmula
    clf;
    hold on;        
    plot(x1,x2);    % dibujo la recta
    gscatter(M(:,1),M(:,2),M(:,3),'rk','oo'); % 
    plot(zeros(1,length(x1)),x1,'color','k'); % dibujo el eje y
    plot(x1,zeros(1,length(x1)),'color','k'); % dibujo el eje x
    axis equal;
    xlim([-2.1 2.1]);
    ylim([-2.1 2.1]);
    str = strcat(desc);
    title(str,'FontWeight','bold','FontSize',12);
    hold off;
    pause(0.25);
end

