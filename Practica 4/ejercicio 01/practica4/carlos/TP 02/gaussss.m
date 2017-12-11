hold on;
for i = 1 : kc
    x = linspace(-2,2);
    y = linspace(-2,2);

    [X,Y] = meshgrid(x,y');

    Z = exp(-20*(1/2)*((X-cent(i,1)).^2 + (Y-cent(i,2)).^2));

    surf(Z);
    scatter3(fd(:,1),fd(:,2),ones(size(fd,1),1));
    
end

% mu = cent(1);
% s = 1;
% 
% p1 = -.5 * ((x - mu)/s) .^ 2;
% p2 = (s * sqrt(2*pi));
% f = exp(p1) ./ p2; 