function [training,test] = crossval(file,k,ratio)
    fd = csvread(file);     % carga el archivo
    [N,M] = size(fd);       % dimensiones de la matriz
    NN = floor(N*ratio);        % cantidad de elementos que entran en N/k
    training = zeros(k,NN,M);
    test = zeros(k,N-NN,M);

    % se requieren k arreglos de matrices de datos
    for i = 1 : k
        % cada arreglo puede ser diferente al anterior (aleatorio)
        index = randperm(N);
        training(i,:,:) = fd(index(1:NN),:);
        test(i,:,:) = fd(index(NN+1:N),:);
    end
end

