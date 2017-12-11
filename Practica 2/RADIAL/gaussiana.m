function [ val_act ] = gaussiana(x,mu,sigma)
    [n m] = size(mu);
     if (sigma == 1)    
         % matriz de covarianza suponiendo sigmas iguales a 1
          U = eye(m);
%           aux = ((2*pi)^(m/2)) * sqrt(norm(U,2));
          aux_2 = (-1/2) * (x-mu) * inv(U) * (x-mu)';
          val_act = exp(aux_2);
     end
    
%         % matriz de covarianza suponiendo sigmas iguales y distintos de 1
%         U = sigma * eye(m, m);
%         U_inv = (1/sigma) * eye(m,m);
% 
%         % matriz de covarianza suponiendo sigmas distintos
%         sigma = mean(sigma_1, sigma_2, sigma_3);
%         U = sigma * eye(m,m);
%         U_inv = (1/sigma) * eye(m);  


end