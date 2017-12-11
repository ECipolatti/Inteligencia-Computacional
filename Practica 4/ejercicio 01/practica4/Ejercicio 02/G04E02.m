% Variables 
cant_particulas = 3;
tol_it = 2; % tolerancia de iteraciones
C1 = 2.5;
C2 = 2.5;
Particulas = round(rand(cant_particulas, 1)*1024 - 512); %Inicializo las particulas
Velocidad = zeros(cant_particulas,1);

Y_global = 1; % Y global iguala cualquier posicion 
Y_personal = zeros(cant_particulas,1); % Las Y_personales son las posiciones iniciales
 figure();
% scatter(Particulas ,Y_personal);
t = 1;
while (t < tol_it)
    for i = 1 : cant_particulas
        if Fitnes(Particulas(i),0,1) > Fitnes(Y_personal(i),0,1)
            Y_personal(i) = Particulas(i); 
        end
        if Fitnes(Y_personal(i),0,1) > Y_global 
            Y_global = Y_personal(i);
        end
    end
    
    for k = 1:cant_particulas 
        velocidad_anterior = Velocidad(k);
        R1 = rand();
        R2 = rand();
        Velocidad(k) = velocidad_anterior + C1*R1*(Y_personal(k) - Particulas(k)) + C2*R2*(Y_global - Particulas(k)); 
        pos_anterior = Particulas(k);
        Particulas(k) = pos_anterior + Velocidad(k);
    end
    hold on;
    scatter(Particulas,Fitnes_M(Particulas,1));
    pause(10);
    
    t = t + 1;
end




