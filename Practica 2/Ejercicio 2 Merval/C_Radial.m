function [ X_y ] = C_Radial(X, mu, sigma)
    [n, ~]=size(X);
    [k, ~]=size(mu);
    
    for i=1:n
        for j=1:k;
%             numerador=norm(X(i,:)-mu(j,:),2);
%             sig=1./mean(sigma(j,:));
%             exponencial= exp((-1/2)*numerador*sig);
%             X_y(i,j)=exponencial;
            sig=1/mean(sigma(j,:));
            X_y(i,j)= exp( (-0.5)*sig*norm(X(i,:)-mu(j,:)));
            
        end
    end
end
