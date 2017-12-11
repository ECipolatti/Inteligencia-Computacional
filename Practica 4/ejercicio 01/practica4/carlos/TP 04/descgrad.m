function [n,x] = descgrad(f,range,maxit,a,b,tol)   
    % gradiente descendiente en 1D y 2D
    % f:        función (simbólica)
    % range:    rango en el que está definida f para el problema
    % maxit:    criterio de corte -> máximo de iteraciones
    % a:        prioriza el valor de la derivada
    % b:        prioriza la diferencia de las derivadas
    % tol:      criterio de corte -> se busca obtener un mínimo con determinada tolerancia
    
    tic;
    syms x y;
    l = length(range);
    if l == 2                               % CASO 1-D
        % inicialización
        dfx = diff(f,'x');                  % se calcula de manera simbólica la derivada de la función
        px = rand();                        % se toma un valor aleatorio entre 0 y 1
        x = px*range(2) + range(1)*(1-px);  % se genera un valor al azar que esté en el rango
        n = 1;                              % se inicializa el contador de iteraciones

        dfxev = double(subs(dfx,x));        % se evalúa la derivada en el valor x aleatorio
        dfxprev = dfxev;                    % se guarda el valor de la derivada

        % primera gráfica
        step = (range(2)-range(1))/100;     % se calcula el paso          
        xl = range(1):step:range(2);        % x lineal con paso step entre range(1) y range(2)
        plot(xl,double(subs(f,xl)));        
        hold on;
        gr = scatter(x,subs(f,x),600,'.');

        % bucle -> mientras no se supere el máximo de iteraciones ni se alcance la toleracia
        % mínima de la derivada ni se salga del rango
        while ((n < maxit) && (dfxev>0+tol || dfxev<0-tol) && (x >= range(1) && x <= range(2)))
            alpha = dfxev-dfxprev;          % diferencia de valores de derivadas
            x = x - a*dfxev + b*alpha;      % actualización de la posición (gradiente)
            dfxprev = dfxev;                % se guarda la derivada anterior
            dfxev = double(subs(dfx,x));    % se calcula la nueva derivada
            n = n+1;                        % se incrementa el contador de iteraciones

            % se grafica nuevamente
            pause(0.5);
            delete(gr);
            gr = scatter(x,double(subs(f,x)),600,'.');
            drawnow;
        end
        hold off;
    elseif l == 4                           % CASO 2-D
        % inicialización
        dfx = diff(f,'x');                  % se calcula de manera simbólica la derivada de la función
        dfy = diff(f,'y');                  % se calcula de manera simbólica la derivada de la función
        px = rand();                        % se toma un valor aleatorio entre 0 y 1 para x
        py = rand();                        % se toma un valor aleatorio entre 0 y 1 para y
        X = px*range(2) + range(1)*(1-px);  % se genera un valor al azar que esté en el rango x
        Y = py*range(3) + range(4)*(1-py);  % se genera un valor al azar que esté en el rango y
        n = 1;                              % se inicializa el contador de iteraciones
        
        % se evalúa la derivada en los valores x,y aleatorios y se guarda el valor
        dfev = [double(subs(dfx,[x y],[X Y])) ; double(subs(dfy,[x y],[X Y]))];
        dfprev = dfev;

        % primera gráfica
        step = (range(2)-range(1))/100;     % se calcula el paso
        [X2,Y2] = meshgrid(range(1):step:range(2),range(3):step:range(4));
        mesh(X2,Y2,(X2.^2+Y2.^2).^0.25.*((sin(50*(X2.^2+Y2.^2).^0.1)).^2+1));
%         mesh(X2,Y2,subs(f,[x,y],[X2,Y2]));
        hold on;
        gr = scatter3(X,Y,subs(f,[x y],[X Y]),1200,'.');

        while ((n < maxit) && (dfev(1)>0+tol || dfev(1)<0-tol) &&...
                (dfev(2)>0+tol || dfev(2)<0-tol) && (X >= range(1) && X <= range(2)) &&...
                (Y>=range(3) && Y<=range(4)))
            alpha = dfev-dfprev;
            X = X-a*dfev(1) + b*alpha(1);
            Y = Y-a*dfev(2) + b*alpha(2);
            dfprev = dfev;
            dfev = [double(subs(dfx,[x y],[X Y])) ; double(subs(dfy,[x y],[X Y]))];
            n = n+1;

            % se grafica nuevamente
            pause(0.5)
            delete(gr);
            gr = scatter3(X,Y,subs(f,[x y],[X Y]),1200,'.');
            drawnow;
        end
    end

    t = toc;
    fprintf('Tiempo de ejecución: %.2f seg\n',t);
end
