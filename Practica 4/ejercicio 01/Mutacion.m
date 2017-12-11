function [ Mutados ] = Mutacion(Genotipos, num_mutados, prob_mutacion, inicio, fin)
     %VARIABLES
    % Genotipos: Genotipos a mutar
    % num_mutados: Cantidad de individuos validos a formar por mutacion
    % prob_mutacion: probabilidad de mutacion de cada genotipo
    % inicio, fin: patrametros necesarios para la validacion
    
    [n,bits] = size(Genotipos);
    Mutados = zeros(num_mutados,bits);
    
    c = 1;
    while c < num_mutados+1
        gen_a_mutar = randi(bits);
        m = 0;
        for i=1:n
            if rand(1) < prob_mutacion
                mutar = Genotipos(i,:);
                if mutar(gen_a_mutar) == 0
                    mutar(gen_a_mutar) = 1;
                else
                    mutar(gen_a_mutar) = 0;
                end
                if Validacion(mutar,inicio,fin)
                    Mutados(c,:) = mutar;
                    m = 1;
                    break;
                end
            end
        end
        c = c + m;
    end
end

