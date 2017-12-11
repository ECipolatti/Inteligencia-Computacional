function [ er ] = TestSOM( Tst, mapa, nro_filas, nro_columnas)
    [n m] = size(Tst);
    dist = zeros(nro_filas, nro_columnas);
    er=0;
    for p = 1 : n
        for i = 1 : nro_filas
            for j = 1 : nro_columnas
                dist(i,j) = norm( Tst(p,1:2) - mapa{i,j}.W , 2);
            end
        end
        [M,I] = min(dist(:));
        [mrow, mcol] = ind2sub(size(dist), I);
        if (mapa{mrow, mcol}.E) ~= Tst(p,3)
            er = er + 1;
        end
    end
    
end