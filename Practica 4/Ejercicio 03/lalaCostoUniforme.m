clear all;
close all;
% clc;
addpath('../Datos');
archivo = '7cities.csv';
nodoRaiz = 7; % 7 para 7cities sino es 5

tic;

D = csvread(archivo);
[n, m] = size(D); 
% nnodos = size(D,1); nnodos = n
Caminos(1,:) = [0 1 nodoRaiz 0];

Nodos = [1:n];
Nodos(Nodos == nodoRaiz) = [];

nodosPosibles(1:length(Nodos),:)  = [ones(length(Nodos),1)  Nodos' D(nodoRaiz,Nodos)'];
nodosPosibles = sortrows(nodosPosibles, 3);

while nodosPosibles(1,2) ~= nodoRaiz
    Caminos = [ Caminos; nodosPosibles(1,1) Caminos(end,2)+1 nodosPosibles(1,2:3) ];
    nodosPosibles(1,:) = [];
    Camino = Caminos(end,3);
    padre = Caminos(end,1);
    while padre ~= 0
        Camino = [Caminos(padre,3) Camino];
        padre = Caminos(padre,1);
    end
    Nodos = [1:n];
    Nodos = setdiff( Nodos , Camino );
    if length(Nodos) == 0
        nodosPosibles = [ nodosPosibles; (Caminos(end,2)) nodoRaiz ...
                            (Caminos(end,4) + D(Caminos(end,3),nodoRaiz)) ];
    else
        nodosPosibles = [ nodosPosibles; repmat(Caminos(end,2), length(Nodos), 1) Nodos' ...
                            Caminos(end,4)+D(Caminos(end,3),Nodos)'];
    end
    nodosPosibles = sortrows(nodosPosibles, 3);
end

mejorCosto = nodosPosibles(1,3);
mejorCamino = [nodosPosibles(1,2)];
padre = nodosPosibles(1,1);
while padre ~= 0
    mejorCamino = [Caminos(padre,3) mejorCamino];
    padre = Caminos(padre,1);
end

time = toc;
