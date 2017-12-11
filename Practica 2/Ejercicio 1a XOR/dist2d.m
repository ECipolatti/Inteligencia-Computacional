function [ d ] = dist2d( P, mu )
    n = length(mu(:,1));
    d = zeros(n, 1);
    for i=1 : n
        d(i) = (norm(P - mu(i,:)))^2;
    end
end

