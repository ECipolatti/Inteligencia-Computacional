function [fen] = gen2fen(gen,range)
    % cambia de genotipo a fenotipo
    if (length(range)==2)       % 1D
        fen = bi2de(gen,'left-msb');                    % de binario a decimal
        maxv = 2^(size(gen,2))-1;                       % máximo valor que se puede generar 
        fen = (fen*range(2)+range(1)*(maxv-fen))/maxv;  % interpolación lineal
    elseif (length(range)==4)   % 2D
        % Se busca la mitad, la mitad de los bits corresponden a x y el resto a y 
        h = round(size(gen,2)/2);
        fen(:,1)= bi2de(gen(:,1:h),'left-msb');
        fen(:,2)= bi2de(gen(:,h+1:end),'left-msb');
        %Se calcula el valor más grande que se puede generar para x y para y
        maxv = 2^(h)-1;
        fen(:,1) = (fen(:,1)*range(2)+range(1)*(maxv-fen(:,1)))/maxv;   % interpolación lineal
        fen(:,2) = (fen(:,2)*range(4)+range(3)*(maxv-fen(:,2)))/maxv;   % interpolación lineal
    end
end

