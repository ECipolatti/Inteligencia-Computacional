function [H]=cruza(M,cant_h)
    % M = matriz de cromosomas padres
    % cant_h = Cantidad de hijos que quiero generar
    [n, m] = size(M);
    H = zeros(cant_h,m);
    for i=1:2:cant_h
       ih1 = 1+floor(rand()*(n-1));
       ih2 = 1+floor(rand()*(n-1));            
       punto_cruza = 2+floor(rand()*(m-2));
       
       for j=1:punto_cruza-1
          H(i,j)=M(ih1,j);
          H(i+1,j)=M(ih2,j);
       end
       for j=punto_cruza:m
          H(i,j)= M(ih2,j);
          H(i+1,j)= M(ih1,j);
       end
    end
    
    %     blacklist=[];
%     for i=1:n
%        if (rand()*100<=p) && (~(findV(blacklist,M(i,:))))
%            blacklist=[blacklist; M(i,:)];
%            aux=[];
%            while true;
%                indice = 1+floor(rand()*(n-1));
%                if ~(findV(blacklist,M(indice,:)))
%                    V_cruza = M(indice,:);
%                    blacklist=[blacklist; M(indice,:)];
%                    break;
%                end
%            end
%            
%            punto_cruza = 2+floor(rand()*(m-2));
%            aux = [ M(i,punto_cruza:end) ];
%            for j=punto_cruza:m
%               M(i,j)= V_cruza(j);
%               M(indice,j)=aux(j-punto_cruza+1);
%            end
%        end
%     end
end
