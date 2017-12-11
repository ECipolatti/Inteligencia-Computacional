function [ mapa ] = trainSOM( trn , mapa, nro_filas, nro_columnas)
    Trn = trn(:, 1:2);
    [n m] = size(Trn);
    max_epocas = 200;
    epoca = 1;
    while (epoca < max_epocas)
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
                    dist(i,j) = norm( Trn(p,:) - mapa{i,j}.W , 2);
                end
            end
            [M,I] = min(dist(:));
            [mrow, mcol] = ind2sub(size(dist), I);
            if (vecindad ~= 0)
                [tl, br] = vecinos(mrow, mcol, nro_filas, nro_columnas, vecindad);
                for row = tl(1) : br(1)
                    for col = tl(2) : br(2)
                        if ( (abs(mrow - row) + abs(mcol - col)) <= vecindad)
                            mapa{row, col}.W = mapa{row, col}.W + lnr * (Trn(p,:)- mapa{row, col}.W);
                        end
                    end
                end
            else
                mapa{mrow, mcol}.W = mapa{mrow, mcol}.W + lnr * (Trn(p,:)- mapa{mrow, mcol}.W);
                if (epoca == (max_epocas-1))
                    mapa{mrow, mcol}.C(trn(p,3) + 1) =  mapa{mrow, mcol}.C(trn(p,3) + 1) + 1;
                end
            end
        end
        epoca = epoca+1
    end
    
    % Etiqueto cada neurona teniendo en cuenta los contadores modificados en la última época
    for i = 1 : nro_filas
        for j = 1 : nro_columnas
            [~ , pos] = max(mapa{i,j}.C);
            mapa{i, j}.E = pos-1;
        end
    end
end