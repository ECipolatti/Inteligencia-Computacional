function [training,test] = kfold(file,k)
    fd = csvread(file);     % carga el archivo
    [N,M] = size(fd);       % dimensiones de la matriz
    NN = floor(N/k);        % cantidad de elementos que entran en N/k
    training = zeros(k,N-NN,M);
    test = zeros(k,NN,M);

    % primero aleatorizamos para evitar trabajar con datos ordenados
    index = randperm(N);
    training(1,:,:) = fd(index(NN+1:N),:);
    test(1,:,:) = fd(index(1:NN),:);

    for i = 2 : k-1
        training(i,1:(i-1)*NN,:) = fd(index(1:(i-1)*NN),:);
        test(i,:,:) = fd(index((i-1)*NN+1:i*NN),:);
        training(i,(i-1)*NN+1:N-NN,:) = fd(index(i*NN+1:N),:);
    end

    training(k,:,:) = fd(index(1:N-NN),:);
    test(k,:,:) = fd(index(N-NN+1:N),:);
end

