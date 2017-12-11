function [Mu,Y,W,epoca,error_por_epoca,inv_covarianza]=RBF_merval(DatosOriginales,k,max_epoca,vel_ap)

[cantDatos,~]=size(DatosOriginales);
Datos=DatosOriginales(:,1:5); %Solo datos (sin las Yd)
Yd=DatosOriginales(:,end);


% Entrenamiento no Supervisado

[cellClases,vecClases,Mu]=k_medias(Datos,k);
[k,Mu,cellClases]=elimina_ceros(Mu,cellClases);

[matriz_covarianza,inv_covarianza]=calcula_matriz_covarianza(cantDatos,cellClases,Mu,false,64000);


% Entrenamiento Supervisado

W = rand(1,k+1)-0.5;
epoca=1;
while (epoca<max_epoca)
        
    for i=1:cantDatos %para cada patron
        for j=1:k % y para cada conjunto
           
            SalidaGaussianas(j,:) = exp(((-0.5)*norm(Datos(i,:)-Mu(j,:)).^2)*((inv_covarianza(j,j))^2));
            
        end
        Entradas_Perceptron = [-1;SalidaGaussianas];
        Salida_Perceptron = W*Entradas_Perceptron;
        error = Yd(i)' - Salida_Perceptron;
        W = W + (vel_ap*error)*Entradas_Perceptron';
    end
    


    for i=1:cantDatos
        for j=1:k
            Salida(j,:) = exp(((-0.5)*norm(Datos(i,:)-Mu(j,:)).^2)*((inv_covarianza(j,j))^2));

        end
        Entrada = [-1;Salida];
        Y(i) = W*Entrada;
    end
    
    error_por_epoca(epoca) = norm((Yd-Y'),2);
    epoca = epoca + 1;
    
end

end