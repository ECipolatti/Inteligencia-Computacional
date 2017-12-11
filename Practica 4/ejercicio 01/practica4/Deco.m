function [ Fenotipo ] = Deco(Genotipo, inicio, fin) %inicio y fin del rango de valores
    [n, m] = size(Genotipo);
    Fenotipo = zeros(n,1);    
    for i=1:n
        Fenotipo(i) = bin2dec(num2str(Genotipo(i))) + inicio;
    end
end