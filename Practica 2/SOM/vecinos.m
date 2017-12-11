function [ tl , br ] = vecinos( row, col, nro_filas, nro_columnas, vecindad )
    up = round(row - vecindad);
    if (up < 1)
        up = 1;
    end
    
    down = round(row + vecindad);
    if (down > nro_filas)
        down = nro_filas;
    end
    
    left = round(col - vecindad);
    if (left < 1)
        left = 1;
    end
    
    right = round(col + vecindad);
    if (right > nro_columnas)
        right = nro_columnas;
    end
    
    tl = [up left];
    br = [down right];
end

