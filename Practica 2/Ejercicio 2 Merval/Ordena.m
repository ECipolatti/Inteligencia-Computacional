function [ D_Ordena ] = Ordena(Data, indices)
    [n,m] = size(Data);  
    D_Ordena = zeros(n,m);
    for i=1:n
        for j=1:n
            if indices(j) == i
                D_Ordena(i,:) = Data(j,:);
            end
        end
    end
end

