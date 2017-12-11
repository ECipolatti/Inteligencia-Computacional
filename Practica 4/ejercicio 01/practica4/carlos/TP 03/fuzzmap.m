function [y] = fuzzmap(M,type_M,S,type_S,r,x)
    % M: matriz de parámetros de los conjuntos de entrada
    % S: matriz de parámetros de los conjuntos de salida
    % type: tipo de función de membresía -> 't': trapecio; 'g'
    % r: vector con las reglas de activación
    % x: valor de la entrada
    
    % control de tipo de función de membresía correcto
    type_M = lower(type_M);
    type_S = lower(type_S);
    if type_M ~= 't' && type_M ~= 'g'
        error('Tipo de función de membresía incorrecto (entrada).');
    end
    
    if type_S ~= 't' && type_S ~= 'g'
        error('Tipo de función de membresía incorrecto (salida).');
    end
    
    % En M tengo los grupos de entrada de 1 a P. en r tengo para cada uno de los P grupos
%     % su equivalente grupo de salida. lo que hago entonces es ordenar la salida de acuerdo
    % al mapeo
%     S = S(r,:);
    mu = membvec(M,type_M,x);
    mu = mu(r);
    y = defuzzify(S,type_S,mu);
end

