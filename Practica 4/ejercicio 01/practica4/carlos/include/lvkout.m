function [train,test] = lvkout(x,k,i)
    N = size(x,1);
    
    if(k>N/4)
        error('k es mayor a N/4.')
    end

    tini = (i-1)*k+1;
    tend = tini+k-1;
    
    test = x(tini:tend,:);
    train = [x(1:tini-1,:);x(tend+1:end,:)];
end
