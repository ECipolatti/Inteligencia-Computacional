function [ seleccionados ] = Competencia( k, Genotipos, num_ganadores, type_fitnes, tasa )
    [n, m]= size(Genotipos);
    seleccionados = zeros(num_ganadores, m);
    menor = 1000000;
    
    for i = 1 : num_ganadores
        vec = round(rand(k, 1) * (n-1))+1;
        gan = 1;
        for j = 1 : k
            g = Decodificacion(Genotipos(vec(j),:));
            num = Fitnes(g(1), 0, type_fitnes, tasa);
            if (num < menor)
                menor = num;
                gan = vec(j);
            end
        end
        seleccionados(i, :) = Genotipos(gan, :);
    end
end

