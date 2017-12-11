function [ Centroides ] = McQueen(k, Data)
    [n, ~] = size(Data);
    Data = Data(randperm(n), :);     % Mezclo los datos para eliminar dependencia
    Centroides = Data(1 : k, :);       % Selecciono los k primeros
end

