clear all;
close all;

[datos_originales,datos_ordenados]=OrdenaMerval('merval.csv');
% [ datos_ordenados ] = Crea_Patrones('merval.csv');
% plot(datos_originales);


[cant_datos,~]=size(datos_ordenados); 

[datos_ordenados_trn,datos_ordenados_tst]=particionaDatos(datos_ordenados,0.8);
%     cant_trn=fix(cant_datos*0.8);
%     cant_tst=cant_datos-cant_trn;
% 
%     n=floor(cant_datos/cant_tst);
%     c1=1;
%     c2=2;
%     for i=1:cant_datos
% 
%         if mod(i,n)==0
%             datos_ordenados_tst(c1,:)=datos_ordenados(i,:);
%             c1=c1+1;
%         else
%             datos_ordenados_trn(c2,:)=datos_ordenados(i,:);
%             c2=c2+1;
%         end
%     end


k=20;
max_epoca=500;
vel_ap=0.03;
% [Mu,Y,W,epoca,error_por_epoca,inv_covarianza]=RBF_merval(DatosOriginales,k,max_epoca,vel_ap)
[Mu,Y_trn,W,epoca,error_trn,inv_covarianza]=RBF_merval(datos_ordenados_trn,k,max_epoca,vel_ap);
[Y_tst,error_tst]=RBF_merval_tst(datos_ordenados_tst,Mu,W,inv_covarianza);



subplot(3,1,1);
plot(datos_ordenados(:,end),'*');

subplot(3,1,2);
plot(Y_trn,'*')

subplot(3,1,3);
plot(Y_tst,'*')


