function [W er ep]=entrenamiento()
alpha = 0.1; %cte velocidad apren.
max_epocas = 8;
error = 0.3;
W = rand([3 1]) - 0.5; % Pesos arbitrarios como para arrancar
D = csvread('OR_trn.csv');
unos = -ones(1,length(D(:,1)))';
X=[unos D(:,1:2)]; %entradas de entrenemiento o patrones
YD = D(:,3); % salidas de entrenamiento
YR = (W'*X')'; %Y obtenida
YR(:)=signo(YR(:));
ep=0;
while(ep < max_epocas)
    for i=1:length(YD)
        W=W-alpha*(YD(i)-YR(i))*X(i,:)';
    end
    ep=ep+1;
    er = abs(sum(YD(:)-YR(:))/4000);
    if(er < error)
        ep = max_epocas; 
        fprintf('corte por error');
    end
end
end