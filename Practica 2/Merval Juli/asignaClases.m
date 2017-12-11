function [cellClases,vecClases]=asignaClases(Datos,Mu)

[cantDatos,~]=size(Datos);
[cantConjuntos,~]=size(Mu);
vecClases=zeros(cantDatos,1);

 for i=1:cantDatos
     
     distancias=zeros(cantConjuntos,1);
    
     for j=1:cantConjuntos
        distancias(j)= sum((Datos(i,:)- Mu(j,:)).^2);
     end
    
    [~,idx]=min(distancias);
    vecClases(i)=idx;
    
 end
 
 for i=1:cantConjuntos
     cellClases{i}=Datos(vecClases==i,:);
 end
 
 
%aca no se como sería para hacerlo variable
%en primcipio es de 4 xq en el caso del xor usamos 4 y con el irish 3
%asi que con el irish no usarimos el ultimo
% cont1=1;
% cont2=1;
% cont3=1;
% cont4=1;
% cont5=1;
% cont6=1;
% cont7=1;
% cont8=1;
% cont9=1;
% cont10=1;
% 
%      for i=1:cantDatos
%          switch vecClases(i)
%              case 1
% 
%              cellClases{1}(cont1,:)= Datos(i,:);
%              cont1=cont1+1;
% 
%              case 2
%              cellClases{2}(cont2,:)= Datos(i,:);
%              cont2=cont2+1;
% 
%              case 3
%              cellClases{3}(cont3,:)= Datos(i,:);
%              cont3=cont3+1;
% 
%              case 4
%              cellClases{4}(cont4,:)= Datos(i,:);
%              cont4=cont4+1;
%              
%              case 5
%              cellClases{5}(cont5,:)= Datos(i,:);
%              cont5=cont5+1;
%              
%              case 6
%              cellClases{6}(cont6,:)= Datos(i,:);
%              cont6=cont6+1;
%              
%              case 7
%              cellClases{7}(cont7,:)= Datos(i,:);
%              cont7=cont7+1;
%              
%              case 8
%              cellClases{8}(cont8,:)= Datos(i,:);
%              cont8=cont8+1;
%              
%              case 9
%              cellClases{9}(cont9,:)= Datos(i,:);
%              cont9=cont9+1;
%              
%              case 10
%              cellClases{10}(cont10,:)= Datos(i,:);
%              cont10=cont10+1;
%              
%              otherwise
%              cellClases{11}(cont11,:)= Datos(i,:);
%              cont11=cont11+1;    
%              
%          end
%  
     
 end
 
     
     
     
     