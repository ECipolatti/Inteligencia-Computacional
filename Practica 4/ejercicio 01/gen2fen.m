function [ Fenotipo ] = gen2fen(Genotipo, inicio)
    %VARIABLES
    % Genotipo: cromosomas a decodificar
    % inicio: inicio de rango de valores a representar
    
    [n, ~] = size(Genotipo);
    Fenotipo = zeros(n,1);    
    for i=1:n
        num = bi2de(Genotipo(i,:),'left-msb');
        Fenotipo(i) = num + inicio;
    end
end