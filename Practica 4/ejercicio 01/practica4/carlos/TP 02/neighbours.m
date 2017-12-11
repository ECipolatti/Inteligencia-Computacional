function [tl,br] = neighbours(row,col,RN,A)
    % devuelve una vecindad cuadrada de amplitud A y valida los límites
    % [1,H] -> vertical y [1,L] -> horizontal
    H = RN(1);
    L = RN(2);
    up = round(row-A);
    if (up < 1)
        up = 1;
    end
    
    left = round(col-A);
    if (left < 1)
        left = 1;
    end
    
    down = round(row+A);
    if (down > H)
        down = H;
    end
    
    right = round(col+A);
    if (right > L)
        right = L;
    end
    
    % tl -> top left (esquina superior izquierda de la matriz)
    % br -> botrom right (esquina inferior derecha de la matriz)
    tl = [up,left];
    br = [down,right];
end
