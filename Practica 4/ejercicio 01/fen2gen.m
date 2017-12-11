function [ Genotipo ] = fen2gen(Fenotipos, genes_cromosomas, min)
    %VARIABLES
    % Fenotipos : fenotipos a pasar
    % genes_cromosomas: bits necesarios para el cromosoma
    
    [n, ~] = size(Fenotipos);
    Genotipo = zeros(n, genes_cromosomas);  
    Fenotipos = Fenotipos + abs(min);
    for i=1:n
        Genotipo(i,:) = de2bi(Fenotipos(i),genes_cromosomas,'left-msb');
    end

end
