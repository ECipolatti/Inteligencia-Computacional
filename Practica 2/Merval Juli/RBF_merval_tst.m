function [Y,error_por_epoca]=RBF_merval_tst(DatosOriginales,Mu,W,inv_covarianza)
[cantDatos,~]=size(DatosOriginales);

Datos=DatosOriginales(:,1:5); %Solo datos (sin las Yd)
Yd=DatosOriginales(:,end);

[k,~]=size(Mu);


   for i=1:cantDatos
        for j=1:k
            Salida(j,:) = exp(((-0.5)*norm(Datos(i,:)-Mu(j,:)).^2)*((inv_covarianza(j,j))^2));

        end
        Entrada = [-1;Salida];
        Y(i) = W*Entrada;
    end
    
    error_por_epoca = norm((Yd-Y'),2);

    
end
