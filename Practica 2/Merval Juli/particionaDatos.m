function [datos_ordenados_trn,datos_ordenados_tst]=particionaDatos(datos_ordenados,porc_trn)

[cant_datos]=size(datos_ordenados);
    cant_trn=fix(cant_datos*porc_trn);
    cant_tst=cant_datos-cant_trn;

    n=floor(cant_datos/cant_tst);
    c1=1;
    c2=2;
    for i=1:cant_datos

        if mod(i,n)==0
            datos_ordenados_tst(c1,:)=datos_ordenados(i,:);
            c1=c1+1;
        else
            datos_ordenados_trn(c2,:)=datos_ordenados(i,:);
            c2=c2+1;
        end
    end
 
    
end
        
    

% vec_tst=randi(cant_datos,1,cant_tst);
% vec_tst=sort(vec_tst);
% datos_ordenados_tst=datos_ordenados(vec_tst,:);
% 
% 
%     
% vec_trn1 = zeros(cant_datos,1);
% vec_trn1 = ones(vec_tst,1);
% vec_tst = find(~vec_trn1);
% end

