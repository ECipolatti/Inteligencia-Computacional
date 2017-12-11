function [n,fen] = genalg(M,N,mrate,prate,crprob,gap,maxit,idle,range,method,k,f,ff)
    % algoritmo genético
    % M:        cantidad de individuos en la población
    % N:        cantidad de genes por cromosoma
    % mrate:    tasa de mutaciones (entre 0 y 1) -> genes mutados por población
    % prate:    tasa de padres a seleccionar
    % crprob:   probabilidad de que se produzcan cruzas
    % maxit:    cantidad máxima de iteraciones
    % idle:     tolerancia de iteraciones sin mejoras en la población
    % range:  	rango donde está definido el problema
    % k:        cantidad de individuos seleccionados para competencia
    % f:        función a hallar el mínimo global
    % ff:       función de aptitud (fitness) correspondiente

    tic

    % inicialización
    P = randi([0,1],M,N);               % generación de individuos de forma aleatoria
    n = 1;                              % contador de iteraciones
    bestFit = zeros(maxit,1);           % vector con mejor aptitud

    % evaluación de la población actual:
    fen = gen2fen(P,range);             % se pasa de genotipo a fenotipo
    [fitness,bestFit(n),m] = evalFitness(fen,ff); % se calcula el fitness de cada individuo
    % gráfica de la función y los cromosomas y comparación con el fitness
    graphGA(f,ff,range,fen,fitness,m);

    c = 0;                              % contador de iteraciones sin mejora del mejor fitness
    while(c < idle && n < maxit)
        F = selection(P,prate,k,fitness,method);        % selección de progenitores
        S = reproduction(P,F,mrate,crprob);             % reproducción
        P = replace(P,S,m,gap);                             % reemplazo
        
        % evaluación de la población actual:
        n = n+1;
        fen = gen2fen(P,range);                         % se pasa de genotipo a fenotipo
        [fitness,bestFit(n),m] = evalFitness(fen,ff);   % se calcula el fitness de cada individuo
        if mod(n,2) == 0
            graphGA(f,ff,range,fen,fitness,m);
        end
        if (bestFit(n) == bestFit(n-1))
            c = c + 1;
        else
            c = 0;
        end
        fprintf('Iteración Nro. %d de %d - Mejor fitness: %f - Inactivo: %d\n',...
            n,maxit,bestFit(n),c);
    end
    graphGA(f,ff,range,fen,fitness,m);
    if c == idle
        str = 'inactividad';
    elseif n == maxit
        str = 'cant- máx. iteraciones';
    end
    disp('-----------------------------------------------------------------------');
    
    fprintf('Mejor fitness: %f - %d iteraciones (corte por %s)\n',...
        bestFit(n),n,str);
    figure();
    plot(1:n,bestFit(1:n));

    t = toc;
    fprintf('Tiempo de ejecución: %f seg\n',t);
end
