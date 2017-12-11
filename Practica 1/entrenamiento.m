function [W, er, ep]=entrenamiento()
alpha = 0.1; %cte velocidad apren.
max_epocas = 8;
error = 0.1;
W = rand([3 1]) - 0.5; % Pesos arbitrarios como para arrancar
D = csvread('XOR_trn.csv');
unos = -ones(1,length(D(:,1)))';
X=[unos D(:,1:2)]; %entradas de entrenemiento o patrones
% scatter(X(:,2),X(:,3),2,(:,3));
YD = D(:,3); % salidas de entrenamiento
ep=0;
while(ep < max_epocas)
    for i=1:length(YD)
        YR(i)=signo(X(i,:)*W); %Y obtenida
        W=W+alpha/2*(YD(i)-YR(i))*X(i,:)';  
        graficar(W);
    end
 
    ep=ep+1;
    er = abs(sum(YD(:)-YR(:))/4000);
    if(er < error)
        fprintf('corte por error');
        fprintf('%d',ep);
        ep = max_epocas; 
    else
       fprintf('Epoca %d',ep); 
    end
end

end