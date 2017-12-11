% Variables 
close all;
clear all;
clc;

cant_particulas = 50;
tol_it = 100; % tolerancia de iteraciones
C1 = 0.7;
C2 = 0.3;
Particulas = round(rand(cant_particulas, 1)*1024 - 512); %Inicializo las particulas
Velocidad = zeros(cant_particulas,1);
type_fitnes = 1;

Y_global = Particulas(1); % Y global iguala cualquier posicion 
Y_personal = Particulas; % Las Y_personales son las posiciones iniciales
figure();
x = linspace(-512,512,100000);
y1 = x.*sin(sqrt(abs(x)));
plot(x,y1);
hold on;
scatter(Particulas ,-Fitnes_M(Particulas,1));
t = 0;
while (t < tol_it)
    for i = 1 : cant_particulas
        if Fitnes(Particulas(i),0,type_fitnes) > Fitnes(Y_personal(i),0,type_fitnes)
            Y_personal(i) = Particulas(i); 
        end
        if Fitnes(Y_personal(i),0,type_fitnes) > Fitnes(Y_global,0,type_fitnes); 
            Y_global = Y_personal(i);
        end
    end
    inercia=(tol_it-t)/tol_it;
    for k = 1 : cant_particulas 
        velocidad_anterior = Velocidad(k);
        R1 = rand();
        R2 = rand();
        Velocidad(k) = inercia*velocidad_anterior + C1*R1*(Y_personal(k) - Particulas(k)) + C2*R2*(Y_global - Particulas(k)); 
        pos_anterior = Particulas(k);
        Particulas(k) = pos_anterior + Velocidad(k);
    end
    Particulas = Verifica_intervalos(Particulas, -512, 512);
    
    x = linspace(-512,512,100000);
    y1 = x.*sin(sqrt(abs(x)));
    plot(x,y1);
    hold on;
    scatter(Particulas,-Fitnes_M(Particulas,1));
    pause(0.1);
    if t < tol_it-1
     clf;
    end
    t = t + 1;
end

vec = Fitnes_M(Particulas,type_fitnes);
[max,ind] = max(vec); 
cant = 0;
for i=1:cant_particulas
    if round((vpa(Particulas(i),6) - vpa(Particulas(ind),6))) == 0
        cant = cant + 1;
    end
end


fprintf('       == RESULTADOS == \n');
fprintf('%d particulas, %d iteraciones \n',cant_particulas, tol_it);
fprintf('mejor posicion: (%.3f,%.3f) \n',Particulas(ind),-max);
fprintf('particulas en la mejor posicon: %d',cant);






