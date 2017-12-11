function [S] = gcross(P,F,crprob)
    % cruza
    % P:    poblaci??n
    % F:    padres
    % S:    nueva poblaci??n
    
    [M,N] = size(P);                    % M individuos de N genes cada uno
    R = size(F,1);                      % R cantidad de progenitores
    if M < 2*R                          % se controla que se mantengan las dimensiones de la poblaci??n
        error('Cantidad de cruzas supera el tamaño de la población');
    end
    % representa la probabilidad de que haya cruzas
    if rand(1) > crprob                 % tomo un número al azar entre 0 y 1. si está entre
        S = P;                          % 0 y crprob entonces continúo, sino devuelvo la misma        
        return;                         % población que entró y salgo del algoritmo
    end                                 
    
    c = 0;
    S = zeros(M,N);                     % preparo los hijos (iguales dimensiones a la población actual)
    while c < M                         % hasta crear M hijos
        prog1 = randperm(R);            % se elige al azar el orden para el progenitor 1
        prog2 = randperm(R);            % se elige al azar el orden para el progenitor 2
        while (sum(prog1 == prog2) > 0) % se aleatoriza prog2 de forma que no queden padres
            prog2 = randperm(R);        % ordenados en la misma columna, es decir, que se
        end                             % puedan cruzar consigo mismos
        j = 1;
        for i = 1 : 2 : 2*R
            crossp = randi([1 N],1,1);      % punto de cruza aleatorio
            % se crea un hijo con la cruza de la primera parte de prog1 con la última de prog2
            if c == M
                return;
            else
                S(i,:) = [F(prog1(j),1:crossp) F(prog2(j),crossp+1:end)];
                c = c+1;
            end
            % se crea otro hijo con la cruza de la primera parte de prog2 con la ??ltima de prog1
            if c == M
                return;
            else
                S(i+1,:) = [F(prog2(j),1:crossp) F(prog1(j),crossp+1:end)];
                c = c+1;
            end
            j = j+1;
        end
    end
end
