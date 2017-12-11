function [train,test] = kfold(fd,k,i)
    if k == 1
        error('K necesita ser mayor a 1');
    end
        
    N = size(fd,1);         % cantidad de filas
    Nk = floor(N/k);        % cantidad de elementos que entran en N/k
    
    tst_beg = (i-1)*Nk+1;
    tst_end = i*Nk;

    test = fd(tst_beg:tst_end,:);
    train = [fd(1:tst_beg-1,:); fd(tst_end+1:end,:)];
end