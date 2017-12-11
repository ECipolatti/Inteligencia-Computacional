clear all; clc; close all;
ini_val = -512;
fin_val = 512;
num_poblacion = 100;
metodo_seleccion = 'V'; % V = Ventana, R = Ruleta, C = Competencia
largo_gen = 11; % Largo del genotipo. 1 bit para signo y 10
type_fitnes = 1;
tasa = 0.1;

Fenotipos = round(rand(num_poblacion, 1)*1024 - 512);

[ G ] = Codificacion(Fenotipos,largo_gen);
[ F ] = Decodificacion(G);

[ S ] = Competencia(2, G, 5, type_fitnes, tasa);

[ Vec_Fitnes ] = Fitnes_Matrix( G, type_fitnes, tasa );

[ seleccionados ] = Ventana( 2 , G, type_fitnes, tasa );

[ seleccionados ] = Ruleta(5, G, type_fitnes, tasa );


