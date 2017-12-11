function [ Particiones ,g ] = leave_k_out(Data, k, genera)
    Data = mezclar(Data);
    [N M] = size(Data);
    % Cantidad de Grupos neesarios, hay que corroborar que N y K 
    if floor(N/k) == N/k
        g = N/k;
    else
        g = floor(N/k) + 1;
    end
    nro_archivos = g*2;
    
    for i = 1 : g
       Particiones{i}.E = zeros(N-k, M);
       Particiones{i}.P = zeros(k, M);        
    end

    for i = 1 : k : N-k
       Particiones{(i-1)/k+1}.P = Data(i : i+k-1 ,:);
       Particiones{(i-1)/k+1}.E = [Data(1:i-1,:);Data(i+k:N,:)];
    end
    
    Particiones{g}.P = Data(N :-1: N-k+1, :);
    Particiones{g}.E = Data(1:N-k, :);
    
    %Guardo en archivos las particiones si genera = 1
    if genera==1
       for i = 1 : g
         nombre_E = strcat('Entrenamiento_', strcat(int2str(i),'.csv'));
         nombre_P = strcat('Prueba_', strcat(int2str(i),'.csv'));
         csvwrite(nombre_E,Particiones{i}.E);
         csvwrite(nombre_P,Particiones{i}.P);
        end
    end
end

