close all;
clear all;
clc;

cant_particulas = 50;
tol_it = 100; % tolerancia de iteraciones
C1 = 0.7;
C2 = 0.3;
Particulas = round(rand(cant_particulas, 2)*1024 - 512); %Inicializo las particulas
Velocidad = zeros(cant_particulas, 2);
type_fitnes = 3;

Y_global = Particulas(1, :); % Y global iguala cualquier posicion 
Y_personal = Particulas; % Las Y_personales son las posiciones iniciales

figure();
x = linspace(-512, 512, 100000);
y = linspace(-512, 512, 100000);
[X, Y] = meshgrid(x, y);
y3 = (X.^2 + Y.^2).^0.25 + (((sin(50 * (X.^2 + Y.^2))).^2).^0.1 + 1);
surf(X, Y, y3);

% hold on;
% plot3(Particulas(:, 1), Particulas(:, 2), -Fitnes_M2D(Particulas, type_fitnes));

t = 0;
while (t < tol_it)
    for i = 1 : cant_particulas
        if Fitnes2D(Particulas(i, :), type_fitnes) > Fitnes2D(Y_personal(i, :), type_fitnes)
            Y_personal(i, :) = Particulas(i, :); 
        end
        if Fitnes2D(Y_personal(i, :), type_fitnes) > Fitnes2D(Y_global, type_fitnes); 
            Y_global = Y_personal(i, :);
        end
    end
    inercia=(tol_it-t)/tol_it;
    for k = 1 : cant_particulas 
        velocidad_anterior = Velocidad(k, :);
        R1 = rand();
        R2 = rand();
        Velocidad(k, :) = inercia * velocidad_anterior + ...
            C1*R1*(Y_personal(k, :) - Particulas(k, :)) + C2*R2*(Y_global - Particulas(k, :)); 
        pos_anterior = Particulas(k, :);
        Particulas(k, :) = pos_anterior + Velocidad(k, :);
    end
    Particulas = VerificaIntervalos2D(Particulas, -512, 512);
    
%     x = linspace(-512,512,100000);
%     y = linspace(-512, 512, 100000);
%     y3 = (x.^2 + y.^2).^0.25 + (((sin(50 * (x.^2 + y.^2))).^2).^0.1 + 1);
%     plot3(x, y, y3);
%     hold on;
%     plot3(Particulas(:, 1), Particulas(:, 2), -Fitnes_M2D(Particulas, type_fitnes));
%     pause(0.1);
    
    if t < tol_it-1
     clf;
    end
    t = t + 1;
end

vec = Fitnes_M2D(Particulas, type_fitnes);
[max,ind] = max(vec);
cant = 0;
for i = 1 : cant_particulas
    if round((vpa(Particulas(i, :), 6) - vpa(Particulas(ind, :), 6))) == 0
        cant = cant + 1;
    end
end