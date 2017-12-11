function [ S ] = Seleccion(Fenotipos, metodo, num_ganadores, k, fac_reduccion, type_fitnes )
    %VARIABLES
    % Fenotipos: valores a seleccionar
    % metodo: numero que define el metodo a seleccinar [1 2 3]
    % num_ganadores: cantidad de ganadores, Ruleta y Competencia
    % k: cantidad de competidores, Competencia
    % fac_reduccion: reduccion de ventana, Ventana
    % type_fitnes: funcion a minimizar
    
    switch metodo 
        case 'R'                                  
            S = Ruleta(num_ganadores, Fenotipos, type_fitnes);
        case 'C'                                  
            S = Competencia( k, Fenotipos, num_ganadores, type_fitnes);
        case 'V'                                 
            S = Ventana(fac_reduccion, Fenotipos, type_fitnes);
        otherwise                               
            S = Ventana(fac_reduccion, Fenotipos, type_fitnes);
    end
end

