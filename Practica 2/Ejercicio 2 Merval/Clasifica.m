function [ indices ] = Clasifica( Data, mu )  
    [n, ~] = size(Data);
    indices = zeros(n,1);
    for p = 1 : n    %  recorro los patrones
        d = dist2d(Data(p,:), mu);
        [~, ind] = min(d);
        if indices(p) ~= ind
            indices(p) = ind;
        end
    end
end

