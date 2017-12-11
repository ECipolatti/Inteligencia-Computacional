function [ Fenotipos ] = Decodificacion(Genotipos)
    [n,m] = size(Genotipos);
    Fenotipos = zeros(n,1);
    
    for i=1:n
        num = 0;
        num = sum(2.^(0:1:(m-2)).*Genotipos(i,m:-1:2));
        if(Genotipos(i,1) == 1)
            Fenotipos(i) = num * (-1);  
        else
            Fenotipos(i) = num;
        end
    end
end

