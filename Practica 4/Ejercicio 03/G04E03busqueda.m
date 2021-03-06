close all; clear all; clc;

% addpath('../Datos');
% D = csvread('7cities.csv');
% [n, m] = size(D);
% raiz = 7;

D = [0 4 7 3; 4 0 2 6; 7 2 0 5; 3 6 5 0];
[n, m] = size(D);
raiz = 1;

caminos = zeros(1, n+2); % la ultima columna es la de COSTOS
caminos(1,1) = raiz;
caminos(1, end) = inf;

nodosPosibles = [1 : n];
nodosPosibles = setdiff(nodosPosibles, caminos);
largo = 2;
Len=1;
ind=1;
min_encontrado = false;

while ~min_encontrado
    for i = 1 : length(nodosPosibles)
        if length(nodosPosibles)==1    
            caminos = [caminos; caminos(ind,1:Len) nodosPosibles(i) raiz 0];
        else
            caminos = [caminos; caminos(ind,1:Len) nodosPosibles(i) zeros(1, length(nodosPosibles)+1)];
        end
    end
    
    Len = 0;
    for j=1:length(caminos(largo,:))
        if (caminos(largo,j)~=0) % && (j~=m+1))
            Len=Len+1;
        end
    end
    for i=1:length(nodosPosibles)        
        for j=1: Len-1
            caminos(largo+i-1, end) = caminos(largo+i-1, end) + D(caminos(largo+i-1,j),caminos(largo+i-1,j+1));
        end
    end
    
   [val, ind]=min(caminos(:,end));
   
   if (caminos(ind,m)==0)
       caminos(ind,end) = inf;
   else
       caminos(ind,m+1)= raiz;
       caminos(ind,end) = caminos(ind,end)+ D(caminos(ind,m),caminos(ind,m+1));
   end
   
   Len = 0;
   for j=1 : length(caminos(ind,:))
       if ((caminos(ind,j) ~= 0) && (caminos(ind,j) ~= inf))
           Len=Len+1;
       end
   end
   
   largo = largo + length(nodosPosibles);
   nodosPosibles = [1 : n];
   nodosPosibles = setdiff(nodosPosibles, caminos(ind,:));
   
   bandera  =true;
   bandera2 = true;
   for i=1:length(caminos(i,:))
       if caminos(ind,i)~=0
           bandera = false;
           break;
       end
   end
   
   aux = caminos(:,end);
   aux(ind)=[];
   [~, ind2] = min(aux);
   for i=1:length(caminos(1,:))
       if caminos(ind2,i)~=0
           bandera2 = false;
           break;
       end
       if caminos(ind2,end) > val
           bandera2 = false;
       end
   end
   
   if (bandera && bandera2)
       min_encontrado = true;
   end
end
    
    
        
    
