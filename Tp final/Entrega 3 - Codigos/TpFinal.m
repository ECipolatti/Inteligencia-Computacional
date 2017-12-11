% === TP Final : Formacion de semillas para el k-means === %
% Usar diferentes metodos con el fin de encontrar semillas que sirvan
% de buena inicializacion para los Mu que k-means usa para armar los clusters. Luego,
% se miden las caracteristicas de cada cluster para ver que tan buenos son.
clear all; close all;
addpath('./Datos');

% == Lectura de Datos == %
% Iris Plants / 4D / 150 elementos /3 clases
Datos1 = csvread('irisbin.csv');
Data_Iris = Datos1(:, 1 : end-3);

% Nubes_10 / 2D / 10 clases
Datos2 = csvread('AD_10_2.csv');
Data_Nubes = Datos2(:, 1 : end-1);


% Glass Identification / 10D / 6 clases
Datos3 = csvread('glass.csv');
Data_Glass = Datos3(:, 1 : end-1);

% Triangulos_9_2D / 2D / 9 clases
Data_Tria_2 = csvread('Triangulos_9_2D.csv');

% Triangulos_9_6D / 6D / 9 clases
Data_Tria_6 = csvread('T6D.csv');


% == Medidas de calidad == %
it = 2;
% Intra_Cluster, Inter_Cluster, Intra/Inter -> En 30 iteraciones
% Iris Plants
Intra_Iris = zeros(it,6);
Inter_Iris = zeros(it,6);
Tiempo_Iris = zeros(it,6);
Iteraciones_Iris = zeros(it,6);
Ind_DB_Iris = zeros(it,6);
Ind_Dunn_Iris = zeros(it,6);
Ind_CH_Iris = zeros(it,6);

% Nubes_10
Intra_Nubes = zeros(it,6);
Inter_Nubes = zeros(it,6);
Tiempo_Nubes = zeros(it,6);
Iteraciones_Nubes = zeros(it,6);
Ind_DB_Nubes = zeros(it,6);
Ind_Dunn_Nubes = zeros(it,6);
Ind_CH_Nubes = zeros(it,6);

% Glass Identification
Intra_Glass = zeros(it,6);
Inter_Glass = zeros(it,6);
Tiempo_Glass = zeros(it,6);
Iteraciones_Glass = zeros(it,6);
Ind_DB_Glass = zeros(it,6);
Ind_Dunn_Glass = zeros(it,6);
Ind_CH_Glass = zeros(it,6);

% Triangulos_2
Intra_Tria = zeros(it,6);
Inter_Tria = zeros(it,6);
Tiempo_Tria = zeros(it,6);
Iteraciones_Tria = zeros(it,6);
Ind_DB_Tria = zeros(it,6);
Ind_Dunn_Tria = zeros(it,6);
Ind_CH_Tria = zeros(it,6);

% Triangulos_6
Intra_Tria_6 = zeros(it,6);
Inter_Tria_6 = zeros(it,6);
Tiempo_Tria_6 = zeros(it,6);
Iteraciones_Tria_6 = zeros(it,6);
Ind_DB_Tria_6 = zeros(it,6);
Ind_Dunn_Tria_6 = zeros(it,6);
Ind_CH_Tria_6 = zeros(it,6);

% == Evaluacion de los Metodos == %
for k=2:3
    for i = 1:it
        %% Iris Plants
        %k_iris = 3;
        k_iris =k;
        disp('1111');
        [ Inter_Iris(i,:), Intra_Iris(i,:), Iteraciones_Iris(i,:), Tiempo_Iris(i,:), Ind_DB_Iris(i,:), Ind_Dunn_Iris(i,:), Ind_CH_Iris(i,:) ] = Calidad_Metodos( k_iris, Data_Iris );
        %% Nubes_10
        %k_nubes = 10;
        k_nubes = k;
        disp('2222');
        [ Inter_Nubes(i,:), Intra_Nubes(i,:), Iteraciones_Nubes(i,:), Tiempo_Nubes(i,:), Ind_DB_Nubes(i,:), Ind_Dunn_Nubes(i,:), Ind_CH_Nubes(i,:) ] = Calidad_Metodos( k_nubes, Data_Nubes );
        %% Glass Identification
        %k_glass = 6;
        k_glass = k;
        disp('3333');
        [ Inter_Glass(i,:), Intra_Glass(i,:), Iteraciones_Glass(i,:), Tiempo_Glass(i,:), Ind_DB_Glass(i,:), Ind_Dunn_Glass(i,:), Ind_CH_Glass(i,:) ] = Calidad_Metodos( k_glass, Data_Glass );
        %% Triangulos_2
        %k_Tria = 10;
        k_Tria = k;
        disp('44444');
        [ Inter_Tria(i,:), Intra_Tria(i,:), Iteraciones_Tria(i,:), Tiempo_Tria(i,:), Ind_DB_Tria(i,:), Ind_Dunn_Tria(i,:), Ind_CH_Tria(i,:) ] = Calidad_Metodos( k_Tria, Data_Tria_2 );
        %% Triangulos_6
        %k_Tria = 10;
        k_Tria_6 = k;
        disp('6666trianguilitus');
        [ Inter_Tria_6(i,:), Intra_Tria_6(i,:), Iteraciones_Tria_6(i,:), Tiempo_Tria_6(i,:), Ind_DB_Tria_6(i,:), Ind_Dunn_Tria_6(i,:), Ind_CH_Tria_6(i,:) ] = Calidad_Metodos( k_Tria_6, Data_Tria_6 );
    end
    
    %% == Resultados == %
    % Iris
    [ Prom, Desv ] = Resultados(Iteraciones_Iris, Tiempo_Iris, Inter_Iris, Intra_Iris, Ind_DB_Iris, Ind_Dunn_Iris, Ind_CH_Iris);
    nombrearchivo =strcat('Resultados k',int2str(k),' Iris');
    csvwrite(nombrearchivo,[Prom Desv]);
    
    % Nubes
    [ Prom, Desv ] = Resultados(Iteraciones_Nubes, Tiempo_Nubes, Inter_Nubes, Intra_Nubes, Ind_DB_Nubes, Ind_Dunn_Nubes, Ind_CH_Nubes);
    nombrearchivo =strcat('Resultados k',int2str(k),' Nubes');
    csvwrite(nombrearchivo,[Prom Desv]);
    
    % Glass
    [ Prom, Desv ] = Resultados(Iteraciones_Glass, Tiempo_Glass, Inter_Glass, Intra_Glass, Ind_DB_Glass, Ind_Dunn_Glass, Ind_CH_Glass);
    nombrearchivo =strcat('Resultados k',int2str(k),' Glass');
    csvwrite(nombrearchivo,[Prom Desv]);
    
    % Triangulos_2
    [ Prom, Desv ] = Resultados(Iteraciones_Tria, Tiempo_Tria, Inter_Tria, Intra_Tria, Ind_DB_Tria, Ind_Dunn_Tria, Ind_CH_Tria);
    nombrearchivo =strcat('Resultados k',int2str(k),' Triangulos 2D');
    csvwrite(nombrearchivo,[Prom Desv]);
    
    % Triangulos_6
    [ Prom, Desv ] = Resultados(Iteraciones_Tria_6, Tiempo_Tria_6, Inter_Tria_6, Intra_Tria_6, Ind_DB_Tria_6, Ind_Dunn_Tria_6, Ind_CH_Tria_6);
    nombrearchivo =strcat('Resultados k',int2str(k),' Triangulos 6D');
    csvwrite(nombrearchivo,[Prom Desv]);
end

