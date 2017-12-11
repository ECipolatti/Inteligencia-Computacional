function [ Hijos ] = Cruza(Padres, num_hijos, prob_cruza, corte, inicio, fin)
    %VARIABLES
    % Padres: Genotipos a cruzar
    % num_hijos: Cantidad de hijos validos a formar
    % prob_cruza: probabilidad de cruza de cada padre
    % corte: cantidad de bits que se deja a la izquierda del 
    % inicio, fin: patrametros necesarios para la validacion
    
    num_hijos_m = num_hijos;
    if rem(num_hijos,2)~=0
        num_hijos_m = num_hijos +1; 
    end
    [n, bits] = size(Padres);
    Hijos = zeros(num_hijos_m,bits);
    
    c=1;
    while c < num_hijos_m+1
        prog1 = zeros(1,bits);
        prog2 = ones(1,bits);
        p = 0;
        h1 = 0;
        h2 = 0;
        while p < 2 % Selecciono 2 progenitores distintos
            p=0;
            ind1 = randi(n);
            ind2 = randi(n);
            if ind1==ind2 
                break;
            end
            if rand(1) < prob_cruza
                prog1 = Padres(ind1,:);
                p = p + 1;
            end
            if rand(1) < prob_cruza
                prog2 = Padres(ind2,:);
                p = p + 1;
            end
        end
        %valido los hijos
        hijo_aux1 = [prog1(1:corte) prog2(corte+1:end)];
        hijo_aux2 = [prog2(1:corte) prog1(corte+1:end)];
        if Validacion(hijo_aux1,inicio,fin)
            Hijos(c,:) = hijo_aux1;
            h1 = 1;
        end
        if Validacion(hijo_aux2,inicio,fin)
            if h1==1;
                Hijos(c+1,:) = hijo_aux2;
                h2 = 1;
            else
               Hijos(c,:) = hijo_aux2;
               h2 = 1;
            end
        end 
        c = c + h1 + h2;
    end
    Hijos = Hijos(1:num_hijos,:);
end

