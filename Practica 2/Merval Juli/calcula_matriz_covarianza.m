function [matriz_covarianza,inv_covarianza]=calcula_matriz_covarianza(cantDatos,cellClases,Mu,bandera,valor)
[k,cantEntradas]=size(Mu);
matriz_covarianza=zeros(k,k);
varianza=zeros(k,1);
% %opcion 1 averiguar los sigmas
% %--> hace el promedio de las varianzas de la clase por patron 
% %--->((x(i,1)-Mu(j,1)) + ... +(x(i,5) - Mu(j,5)) )/N , con i=1..N y j=1..k 

% for i=1:k
%     varianza(i)=0;
%     [cant_porClase,~]=size(cellClases{i});
% 
%     for j=1:cant_porClase
%         var_por_patron(j)=0;
% 
%         for p=1:cantEntradas
%             var_por_patron(j)= var_por_patron(j)+(cellClases{i}(j,p)-Mu(i,p))^2;
%         end
% 
%         var_por_patron(j)= var_por_patron(j)/cant_porClase;
%     end
%     varianza(i)=mean(var_por_patron);
% end


%opcion 2 --> creo que esta es la que está bien
% %--> hace el promedio de las varianzas de la clase por entrada de patron 
% %---> ((x(1,1)-Mu(1,1)) + ... +(x(1,N) - Mu(1,N)) )/N

     for i=1:k
        varianza(i)=0;
        [cant_porClase,~]=size(cellClases{i});
 
        
        for j=1:cantEntradas
            var_por_patron(j)=0;
            for p=1:cant_porClase
                var_por_patron(j)= var_por_patron(j)+(cellClases{i}(p,j)-Mu(i,j))^2;
            end
            var_por_patron(j)= var_por_patron(j)/cant_porClase;
        end
        varianza(i)=mean(var_por_patron);
   
    end
    
 
    if bandera
        for i=1:k
         matriz_covarianza(i,i)=valor;
        end
    else
        for i=1:k
            if varianza(i)==0;
                 matriz_covarianza(i,i)=1;
            else
                matriz_covarianza(i,i)=varianza(i);
            end
        end
    end

inv_covarianza=inv(matriz_covarianza);

end