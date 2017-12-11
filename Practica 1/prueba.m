function [Er] = prueba()
    T = csvread('XOR_tst.csv');
    scatter(T(:,1),T(:,2),2,T(:,3));
    [W, er, ep]=entrenamiento();
    [n m]=size(T);
    Tst=zeros(n,1);
    for i=1:n
        Ts(i)= signo(T(i,:)*W);
    end
    errores=0;
    Er=0;
    for i=1:n
        Tst(i)=Ts(i)-T(i,3);
        if(Tst(i)~=0)%quiero saber la cantidad de errores del algoritmo
            errores=errores+1;
        end
    end
    Er=errores/n;  
    
end