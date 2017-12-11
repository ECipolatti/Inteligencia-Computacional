function [y,A,C] = defuzzify(S,type,mu)
    % S: matriz de parámetros de dimensiones [P,4] para tipo 't' y [P,2] para tipo 'g'
    % type: tipo de función de membresía -> 't': trapecio; 'g'
    % mu: vector con el grado de activación de cada uno de los conjuntos de entrada
    
    % control de tipo de función de membresía correcto
    type = lower(type);
    if type ~= 't' && type ~= 'g'
        error('Tipo de función de membresía incorrecto.');
    end
    
    P = size(S,1);                  % cantidad de conjuntos    
    C = zeros(P,1);                 % vector para calcular los P centroides
    A = zeros(P,1);                 % vector para calcular las P áreas
    if type == 't'
        for i = 1 : P
            a = S(i,1);
            b = S(i,2);
            c = S(i,3);
            d = S(i,4);
            
            A1 = (b-a)*mu(i)/2;      % área del triángulo de la izquierda 
            A2 = (c-b)*mu(i);        % área del rectángulo
            A3 = (d-c)*mu(i)/2;      % área del triángulo de la derecha
            A(i) = A1 + A2 + A3;    % área del trapecio (área total)
            c1 = a + (2/3)*(b-a);	% centroide del triángulo de la izquierda
            c2 = b + (c-b)/2;       % centroide del rectángulo
            c3 = c + (1/3)*(d-c);	% centroide del triángulo de la derecha
            % centroide del trapecio: cada área x centroide dividido el área total. se
            % controla que no haya divisiones por cero
            if (A(i) == 0)
                C(i) = 0;
            else
                C(i) = (A1*c1 + A2*c2 + A3*c3)/A(i);
            end
        end
    end
    
    if type == 'g'
        for i = 1 : P
            m = S(i,1); % media
            s = S(i,2); % desviación standard
            A(i) = s*sqrt(2*pi)*mu(i);
            C(i) = m;
        end
    end
    % se calcula la salida como cada centroide por su área dividido el área total. se
    % controla que no haya división por cero
    At = sum(A);        % área total
    if At == 0
        y = 0;
    else
        y = dot(A,C)/sum(A);
    end

end

