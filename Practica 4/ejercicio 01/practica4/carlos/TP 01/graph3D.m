function [] = graph3D(w,M,desc)
    [n,~] = size(M);    % n: nro. de filas; m: nro. de columnas

    % armo vectores con las clases para "dibujarlos" con distintos colores
    r1 = [];
    g1 = [];
    r = 1;
    g = 1;
    for i = 1 : n
        if M(i,4) == 1
            r1(r,:) = M(i,1:3);
            r = r+1;
        else
            g1(g,:) = M(i,1:3);
            g = g+1;
        end
    end

    [x1,x2]=meshgrid(-2:0.2:2); %Rango para graficar
    x3 = w(1)/w(4) - w(2)/w(4)*x1 - w(3)/w(4)*x2; % armo la recta a partir de la fórmula

    surf(x1,x2,x3);    % dibujo la recta
    hold on;
    scatter3(r1(:,1),r1(:,2),r1(:,3),2,'r'); % clase 1 ([ 1 ] - rojo)
    scatter3(g1(:,1),g1(:,2),g1(:,3),2,'g'); % clase 2 ([-1 ] - verde)

    axis equal;
    axis([-2 2 -2 2 -2 2])
    xlabel('X1');
    ylabel('X2');
    zlabel('X3');
    str = strcat(desc);
    title(str,'FontWeight','bold','FontSize',12);
    view(3);
    hold off;
    pause(0.25);
end

