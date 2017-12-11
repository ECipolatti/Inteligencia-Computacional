function [k,Mu_aux,cellClases_aux]=elimina_ceros(Mu,cellClases)

% %elimino los mu que no estan asignados a ninguna clase
% [k2,c2]=size(Mu);
% for i=1:c2
%     nan(i)=0;
% end
% j=1;
% for i=1:k2
%     if (~(isequal(Mu(i,:),nan)))
%         Mu_aux(j,:)=Mu(i,:);
%            j=j+1;
%     end
% end
% 
% Mu=zeros(length(Mu_aux),c2);
% Mu=Mu_aux;
% [k,~]=size(Mu);


[k2,c2]=size(Mu);

Mu_ceros=zeros(1,c2);

contador=1;

for i=1:k2
    [cantPatrones,~]=size(cellClases{i});
    
    if cantPatrones~=0
        cellClases_aux{contador}=cellClases{i};
        Mu_aux(contador,:)=Mu(i,:);
        contador=contador+1;
        
    end
end

[k,~]=size(Mu_aux);

end