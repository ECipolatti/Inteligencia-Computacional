%%Ejercicio 3

clc;
clear;
addpath('../datosG02');

Data = csvread('te.csv');
[n m]=size(Data);
lnr = 0.5;
nro_max_epocas  = 500;

%% creo el mapa
nro_filas = 5;
nro_columnas = 5;
nro_neuronas = nro_filas*nro_columnas;
for i=1:nro_filas
    for j=1:nro_columnas
        mapa{(i-1)*nro_columnas +j}.w = rand(1,2);
        mapa{(i-1)*nro_columnas +j}.pos = [i j];
    end
end


%% Encuantro ganadora
%para todos los patrones
epoca = 1;


while (epoca < nro_max_epocas)
    
    if (epoca < nro_max_epocas/3)
        lnr=0.7;
        vecindad = 2;
    else
        if (epoca < nro_max_epocas/3*2)
            lnr=0.1;
            vecindad = 1;
        else
            lnr=0.01;
            vecindad = 0;
        end
    end
    
    
    vec_dist=zeros(nro_neuronas,1);
    for i=1:n %por patrones
        for celda=1:nro_neuronas
            vec_dist(celda) = norm( Data(i,:)-mapa{celda}.w , 2);
        end
        %actualizo la ganadora
        [minimo posi] = min(vec_dist);
        
        %for o=posi-vecindad:posi+vecindad
        
        for c=1:nro_neuronas
            if (abs (mapa{c}.pos(1)-mapa{posi}.pos(1)) <= vecindad ) && (abs (mapa{c}.pos(2)-mapa{posi}.pos(2)) <= vecindad )
                mapa{c}.w = mapa{c}.w + lnr* (Data(i,:)- mapa{c}.w);
                
            end 
        end
        
    end
    
    
    mat_aux = zeros(nro_neuronas,m);
    for i=1:nro_neuronas
        mat_aux(i,:) = mapa{i}.w;
    end
%     figure(1)
%     scatter(mat_aux(:,1),mat_aux(:,2))
%     for r=1:nro_filas-1
%         for h=2:nro_columnas
%             neur=(r-1)*nro_columnas+h;
%             line([mapa{neur}.w(1) mapa{neur-1}.w(1)],[mapa{neur}.w(2) mapa{neur-1}.w(2)]);        
%             line([mapa{neur}.w(1) mapa{neur+nro_columnas}.w(1)],[mapa{neur}.w(2) mapa{neur+nro_columnas}.w(2)])
%         end
%         h=1;
%         neur=(r-1)*nro_columnas+h;
%         line([mapa{neur}.w(1) mapa{neur+nro_columnas}.w(1)],[mapa{neur}.w(2) mapa{neur+nro_columnas}.w(2)])
%     end
%     r=nro_filas;
%     for h=2:nro_columnas
%         neur=(r-1)*nro_columnas+h;
%         line([mapa{neur}.w(1) mapa{neur-1}.w(1)],[mapa{neur}.w(2) mapa{neur-1}.w(2)]);  
%     end
%     axis([-1 1 -1 1])
    epoca = epoca+1
end
hold on
scatter(Data(:,1),Data(:,2),10,'r','x')
hold off
%% actualizo vencidad