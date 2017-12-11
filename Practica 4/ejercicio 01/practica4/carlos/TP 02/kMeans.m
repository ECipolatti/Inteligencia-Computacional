function [idx,C,S] = kMeans(X,k)
    [P,N] = size(X);        % dimensiones de la matriz de datos
    L = floor(P/k);         % cantidad de elementos por grupo (equitativo)
    idx = randi(k,P,1);     % vector de índices de grupos aleatorios
    C = zeros(k,N);         % centroides
    S = zeros(k,N);         % varianza
    maxit = 100;            % cantidad máxima de iteraciones
    nit = maxit;            % inicializo el contador de iteraciones (decrementa)
    factor = 0.1;          % factor para corregir número mínimo de elem. por grupo
%     med = mean(mean(X));
    med = 0;
    
    
    change = true;          % flag para indicar si hubo reasignaciones
    while(change && nit > 0)
        % se calculan los centroides de cada grupo
        for j = 1 : k
            C(j,:) = mean(X(idx == j,:));
        end
        change = false;     % se reinicia la bandera de reasignaciones
        
        
        dist = zeros(1,k);  % para almacenar la distancia del patrón a cada centroide
        for i = 1 : P
            for j = 1 : k   % se calcula la distancia (N p2) del patrón a cada centroide
               dist(j) = norm(X(i,:)-C(j,:));
            end
            
            % si la distancia mínima del patrón a un centroide difiere del
            % centroide guardado, se reasigna a este grupo y se activa la
            % bandera de cambios
            [~,l] = min(dist);
            if l ~= idx(i)
                change = true;
                idx(i) = l;
            end
            
            if mod(i,10) == 0
                for j = 1 : k
                    if size(X(idx == j),1) < factor*L
    %                     C(j,:) = C(j,:)+rand(1,N)-0.5;
                        C(j,:) = med + (rand(1,N)-0.5);
                    end
                end
            end
            
        end
        
        % factor de corrección (EXPERIMENTAL!). si algún grupo tiene
        % una cantidad menor a un factor fijo multiplicado por la
        % cantidad teórica equitativa de elementos por grupo, se
        % reinicializa el centroide. supongo así que algún centroide
        % está demasiado cerca de dos grupos y acapara más cantidad de
        % elementos, mientras que el otro se va vaciando. con este
        % factor se corrige, en principio, este inconveniente
        
        nit = nit-1;
    end
    
    for j = 1 : k       % se calculan las varianzas
        S(j,:) = var(X(idx == j,:));
    end
end

