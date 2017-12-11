function [ Genotipo ] = Codi(inicio, fin) %inicio y fin del rango de valores
    total_numeros = (abs(inicio)+abs(fin))+1;
    bits = fix(log(total_numeros)/log(2));
    Genotipo = zeros(total_numeros,bits);    
    for i=1:total_numeros
        num = i;
        for j=1:bits
            if (num
            Genotipo(i,(bits+1)-j) = mod(num,2);
            num = j;
        end
%         
%         Genotipo(i) = str2num(dec2bin(i-1,bits));
    end
end
