function [ X_y ] = C_Radial(X, mu)
    [n, ~]=size(X);
    [k, ~]=size(mu); 
    
    for i=1:n
        for j=1:k
            X_y(i,j)= exp( (-0.5)*norm(X(i,:)-mu(j,:)));
        end
    end
end

