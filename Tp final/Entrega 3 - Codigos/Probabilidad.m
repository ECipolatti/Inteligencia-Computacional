function [ ganador ] = Probabilidad(Probabilidades)
    Probabilidades = [0; cumsum(Probabilidades)];  
    valor = rand();                               
    for i = 1 : length(Probabilidades) - 1
        if (valor > Probabilidades(i) && valor < Probabilidades(i+1))
            ganador = i;
            break;
        end
    end
end