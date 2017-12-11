clear all; clc; close all;
tic
f = @(x) -x.*sin(sqrt(abs(x))); % función a hallar el mínimo global
ff = @(x) x.*sin(sqrt(abs(x))); % función de aptitud correspondiente
%PARAMETROS
    num_poblacion = 100;
    genes_cromosomas = 10;
    inicio = -512; %inicio rango de valores
    fin = 512; %fin de rango de valores
    max_it = 100; %maximas iteraciones
    tol_cambios = 20; %tolerancia de no modificaciones en el mejor patron
    
    % Seleccion:
    metodo_seleccion = 'R';      % V = Ventana, R = Ruleta, C = Competencia
    num_ganadores = 80;          % cantidad de ganadores, Ruleta y Competencia
    k = 2;                       % cantidad de competidores, Competencia
    fac_reduccion = 3;           % reduccion de ventana, Ventana
    type_fitnes = 1;             % funcion a minimizar

    % Nueva poblacion -> tener en cuenta que se utiliza elitismo
    num_hijos = 80;                             %cantidad de hijos a formar
    prob_cruza = 0.9;                       %probabilidad de cruce entre dos padres
    bit_corte = 2;                          %bit de corte de cruza
    num_mutados = num_poblacion - num_hijos - 1;    %numero de mutados a formar
    prob_mutacion = 0.1;                    %probabilidad de mutacion

    % inicializaciion
    Fenotipos = randperm(fin*2+1,num_poblacion)-(fin+1);
    Genotipos = fen2gen(Fenotipos',genes_cromosomas, inicio);       % inicio con individuos de forma aleatoria
    n = 1;                              % contador de iteraciones
    Mejores_Fitnes = zeros(max_it,1);   % vector con mejor aptitud

    % Evuluacion de individuos actuales:
    [Fitnes, Mejores_Fitnes(n), ind_elite] = Fitnes_Matrix(Fenotipos, type_fitnes); % se calcula el fitness de cada individuo
    Elite = fen2gen(Fenotipos(ind_elite),genes_cromosomas,inicio);
    %Grafica
    graphGA(f,ff,[inicio fin],Fenotipos,Fitnes,ind_elite);

    c = 0;         % contador de iteraciones sin mejora
    while(c < tol_cambios && n < max_it)
        Padres = Seleccion(Fenotipos', metodo_seleccion, num_ganadores, k, fac_reduccion, type_fitnes );     % Seleccion
        Padres = fen2gen(Padres,genes_cromosomas, inicio);
        Hijos = Cruza(Padres, num_hijos, prob_cruza, bit_corte, inicio, fin);                         % Cruza
        Mutados = Mutacion(Hijos, num_mutados, prob_mutacion, inicio, fin);                       % Mutacion
        Genotipos = Reemplazo(Elite, Hijos, Mutados, num_hijos, num_mutados, num_poblacion);      % Reemplazo
        
        % Evuluacion de individuos actuales:
        n = n+1;
        Fenotipos = gen2fen(Genotipos,inicio);                      % % Genotipo -> Fenotipo
        [Fitnes, Mejores_Fitnes(n), ind_elite] = Fitnes_Matrix(Fenotipos, type_fitnes); % se calcula el fitness de cada individuo
        Elite = fen2gen(Fenotipos(ind_elite),genes_cromosomas,inicio);
        if mod(n,2) == 0
            graphGA(f,ff,[inicio fin],Fenotipos,Fitnes,ind_elite);
        end
        if (Mejores_Fitnes(n) == Mejores_Fitnes(n-1))
            c = c + 1;
        else
            c = 0;
        end
        fprintf('Iteracion Nro. %d de %d - Mejor fitness: %f - Inactivo: %d\n',...
            n,max_it,Mejores_Fitnes(n),c);
    end
     graphGA(f,ff,[inicio fin],Fenotipos,Fitnes,ind_elite);
    if c == tol_cambios
        str = 'inactividad';
    elseif n == max_it
        str = 'cant- max. iteraciones';
    end
    disp('-----------------------------------------------------------------------');
    
    fprintf('Mejor fitness: %f - %d iteraciones (corte por %s)\n',...
        Mejores_Fitnes(n),n,str);
    figure();
    plot(1:n,Mejores_Fitnes(1:n));

    t = toc;
    fprintf('Tiempo de ejecucion: %f seg\n',t);
        
