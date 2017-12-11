%%Ejercicio 3
close all; clear;
addpath('./datosG02');

Data = csvread('te.csv');
[n m] = size(Data);
max_epocas = 150;

%% creo el mapa
nro_filas = 10;
nro_columnas = 10;
nro_neuronas = nro_filas * nro_columnas;
for i=1:nro_filas
    for j=1:nro_columnas
        mapa{i,j}.W = (rand(1,2)-.5)*4;
    end
end

%% Encuantro ganadora
%para todos los patrones
epoca = 1;
while (epoca < max_epocas)
    hold off;
    if (epoca < max_epocas/3)
        lnr = 0.7;
        vecindad = 3;
    else
        if (epoca < (max_epocas*2)/3)
            alpha = (0.7 - 0.1) / (max_epocas/3);
            lnr = lnr - alpha;
            vecindad = 1;
        else
            lnr = 0.01;
            vecindad = 0;
        end
    end
        
    dist = zeros(nro_filas, nro_columnas);
    for p = 1 : n
       for i = 1 : nro_filas
           for j = 1 : nro_columnas
               dist(i,j) = norm( Data(p,:)- mapa{i,j}.W , 2);
           end
       end
       [M,I] = min(dist(:));
       [mrow, mcol] = ind2sub(size(dist), I);
       if (vecindad ~= 0)
           [tl, br] = vecinos(mrow, mcol, nro_filas, nro_columnas, vecindad);
           for row = tl(1) : br(1)
               for col = tl(2) : br(2)
                   if ( (abs(mrow - row) + abs(mcol - col)) <= vecindad)
                       mapa{row, col}.W = mapa{row, col}.W + lnr * (Data(p,:)- mapa{row, col}.W);
                   end
               end
           end
       else
           mapa{mrow, mcol}.W = mapa{mrow, mcol}.W + lnr * (Data(p,:)- mapa{mrow, mcol}.W);
       end
    end
    
    % De acá para abajo es para graficar
    wx = zeros(nro_neuronas,1);
    wy = zeros(nro_neuronas,1);

    for i = 1 : nro_filas
        for j = 1 : nro_columnas
            indice = (i-1) * nro_columnas + j;
            wx(indice) = mapa{i, j}.W(1);
            wy(indice) = mapa{i, j}.W(2);
        end
    end
    
    figure(1);
    scatter(Data(:,1), Data(:,2), 30, 'r', 'x');
    hold on
    scatter(wx, wy, 30);
    
    for i = 1 : nro_filas-1
        for j = 2 : nro_columnas
            indice = (i-1) * nro_columnas + j;
            line([wx(indice) wx(indice-1)],[wy(indice) wy(indice-1)]);        
            line([wx(indice) wx(indice+nro_columnas)],[wy(indice) wy(indice+nro_columnas)])
        end
        j=1;
        indice = (i-1) * nro_columnas + j;
        line([wx(indice) wx(indice+nro_columnas)],[wy(indice) wy(indice+nro_columnas)])
    end
    i=nro_filas;
    for j=2:nro_columnas
        indice = (i-1) * nro_columnas + j;
        line([wx(indice) wx(indice-1)],[wy(indice) wy(indice-1)]);  
    end
    hold off;
    axis([-1 1 -1 1]);
%     pause(0.01);
    epoca = epoca+1
end




  


