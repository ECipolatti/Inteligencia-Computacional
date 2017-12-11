function [ Genotipos ] = Codificacion(Fenotipos,largo_gen)
    [n, ~] = size(Fenotipos);
    Genotipos = zeros(n,largo_gen);
    
    for i = 1 : n
        if (Fenotipos(i)<0)
            num_bin = dec2bin(Fenotipos(i)*(-1),10);
            Genotipos(i,1) = 1;
            for j = 1:(largo_gen-1)
                Genotipos(i,j+1) = str2num(num_bin(j));
            end
        else
            num_bin = dec2bin(Fenotipos(i),10);
            for j = 1:(largo_gen-1)
                Genotipos(i,j+1) = str2num(num_bin(j));
            end
        end
    end
end

