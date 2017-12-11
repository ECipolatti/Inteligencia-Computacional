function [best] = learnc(fd,RN,n_in,n_out,phi,top,kc)
    N = size(fd,1);
    if N > top
        N = top;
    end

    idx = randperm(N);
    train_data = fd(idx(1:N),:);
    
    c = linspace(0.1,2,kc);
    
    eta = 0.3;
    gamma = 0.3;
    tol = 90;
    maxep = 150;   
    
    hitp = zeros(1,kc);
    for i = 1 : kc
        hitp(i) = mlp_eval(train_data,RN,n_in,n_out,gamma,eta,maxep,tol,phi,c(i));
    end
    
    [~,m] = max(hitp);
    best = c(m);
end

