function [ valido ] = Validacion( genotipo, inicio, fin )
    %VARIABLES
    % genotipo: genotipo a validar
    % inicio: inicio de rango de valores a representar
    % fin: fin de rango de valores a representar
    
    if inicio < 0 || inicio == 0
        total_numeros = (fin - inicio)+1;
    else
        total_numeros = (fin-inicio);
    end
    
    num = bi2de(genotipo,'left-msb');
    
    if num >= 0 && num < total_numeros
        valido = true;
    else
        valido = false;
    end
    
end

