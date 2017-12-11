function [cellClases,vecClases,Mu]=k_medias(Datos,k)
% Entradas:
% Datos: vector que contiene solo los datos, sin las yd
% k= cantidad de conjuntos

% Salidas:
%cellClases: en cada celda contiene los patrones pertenecientes a cada conjunto
%vecClases: vector que contiene a que clase pertenece cada patron de la matriz Datos
%Mu: centroides ya fijod

Mu=Datos(1:k,:); %elijo mis mu aleatorios para empezar
[~,cantEntradas]=size(Datos);
c=1;

[cellClases,vecClases]=asignaClases(Datos,Mu);

while (true) %mientras haya cambios, sigo entrenando
    

   for i=1:k %recorro por clases
       suma=sum(cellClases{i});% suma-> [x11 x12;x21 x22]=[(x11+x21) (x12 + x22)]
       [cant,~]=size(cellClases{i});
       %pongo en cero aquellos centroides que quedaron sin asignar
        if cant==0;
             Mu(i,:)=zeros(1,cantEntradas);
        else
            Mu(i,:)=suma/cant;%asigno promedio
        end
   end
    
   %vuelvo a reasignar los patrones a las clases
   [cellClases2,vecClases2]=asignaClases(Datos,Mu);
   
    %si no hay mas reasignaciones, salgo
    if (isequal(vecClases,vecClases2))
        cellClases=cellClases2;
        vecClases=vecClases2;
        break;
    end
    
    cellClases=cellClases2;
    vecClases=vecClases2;
    
   c=c+1;
end%fin while

end%fin Func