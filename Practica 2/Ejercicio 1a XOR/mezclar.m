function [ D ] = mezclar( Data )
    [n m] = size(Data);
    D = zeros(n,m);
    indices = randperm(n);
    
    for i=1 : n
        D(i,:) = Data(indices(i), :);
    end
end

