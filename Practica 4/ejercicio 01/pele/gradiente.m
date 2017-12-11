% F(x)= -x sin (sqrt(abs(x)))
clear all; close all; clc

max_iter =200;

funcion = 1;

switch funcion
    case 1
        cant_particulas = 5;
        tol = 0.1;
        dx = .5;
        intervalo_a = -512;
        intervalo_b = 512;
        particulas = rand(cant_particulas,1)*1024-512;
        X=linspace(intervalo_a,intervalo_b,100);
        Y = X; %como para inicializarlo del mismo tama�o

    case 2
        cant_particulas = 5;
        dx = 0.005;
        tol = 0.01;
        intervalo_a = 0;
        intervalo_b = 20;
        particulas = rand(cant_particulas,1)*20;
        X=linspace(intervalo_a,intervalo_b,1000);
        Y = X;

    case 3
        cant_particulas = 20;
        tol = 0.1;
        dx = .5;
        dy = .5;
        intervalo_a = -100;
        intervalo_b = 100;
        particulas = rand(cant_particulas,2)*200-100;
        X=linspace(intervalo_a,intervalo_b,100);
        Y = X;
        Z = zeros(length(X),length(Y));
        particula_z=zeros(cant_particulas,1);
end

%para las graficas de la funciones
for i=1:length(X)
    switch funcion
        case 1
            Y(i)= -X(i)*sin(sqrt(abs(X(i))));
        case 2
            Y(i)= X(i)+5*sin(3*X(i))+8*cos(5*X(i));
        case 3
            for j=1:length(Y)
                Z(i,j) = ((X(i)^2 + Y(j)^2)^.25)*((sin(50*(X(i)^2+Y(j)^2)^.1))^2+1);
            end
    end
end




iter =1;
y_n=ones(cant_particulas,1);
y=zeros(cant_particulas,1);
while ( ((sum(abs(y-y_n))) > tol) && (iter < max_iter))
    switch funcion
        case 1
            y = -particulas.*sin(sqrt(abs(particulas)));
            delta =  dx* - sign( -(power(particulas,2).*cos(sqrt(abs(particulas))))./(2*power(abs(particulas),(3/2)))-sin(sqrt(abs(particulas))));
            particulas = particulas + delta;
        
            for i=1:length(particulas)
                if(particulas(i)<intervalo_a)
                    particulas(i)=intervalo_a;
                end
                if(particulas>intervalo_b)
                    particulas(i)=intervalo_b;
                end
            end
            
            y_n = -particulas.*sin(sqrt(abs(particulas)));
            
        case 2
            for i=1:length(particulas)
                y(i)= particulas(i)+5*sin(3*particulas(i))+8*cos(5*particulas(i));
                delta(i) = dx* - sign( -40*sin(5*particulas(i)) + 15*cos(3*particulas(i)) +1);
            end
            
            particulas = particulas + delta';
            
            for i=1:length(particulas)
                if(particulas(i)<intervalo_a)
                    particulas(i)=intervalo_a;
                end
                if(particulas>intervalo_b)
                    particulas(i)=intervalo_b;
                end
            end
            y_n = particulas+5.*sin(3.*particulas)+8.*cos(5.*particulas);
        
        case 3
            
            for i =1:cant_particulas
                    particula_z(i) = ((particulas(i,1)^2 + particulas(i,2)^2)^.25)*((sin(50*(particulas(i,1)^2+particulas(i,2)^2)^.1))^2+1);       
                    grad = .5*particulas(i,1)*((sin(50*(particulas(i,1)^2+particulas(i,2)^2)^0.1))^2+1)/(particulas(i,1)^2+particulas(i,2)^2)^0.75;
                    grad = grad +(10*particulas(i,1)*sin(100*(particulas(i,1)^2+particulas(i,2)^2)^0.1))/(particulas(i,1)^2+particulas(i,2)^2)^0.65;
                    delta(i,1) =dx*-sign(grad);
                    delta(i,2) =dy*-sign(grad);
            end
            particulas = particulas + delta;
            
            for i=1:length(particulas)
                if(particulas(i,1)<intervalo_a)
                    particulas(i,1)=intervalo_a;
                end
                if(particulas(i,1)>intervalo_b)
                    particulas(i,1)=intervalo_b;
                end
                if(particulas(i,2)<intervalo_a)
                    particulas(i,2)=intervalo_a;
                end
                if(particulas(i,2)>intervalo_b)
                    particulas(i,2)=intervalo_b;
                end
            end
            for i =1:cant_particulas
                particula_z(i) = ((particulas(i,1)^2 + particulas(i,2)^2)^.25)*((sin(50*(particulas(i,1)^2+particulas(i,2)^2)^.1))^2+1);
            end   
    end

    iter = iter+1;
    if ( ((sum(abs(y-y_n))) >= tol) && (iter < max_iter))
        clf;
    end;
    if ((funcion==1) || (funcion==2))
        hold on;
        plot(X,Y);
        scatter(particulas,y_n);
        pause(0.05);
    else
        hold on;
        surf(X,Y,Z);
%         scatter2D(y_n,particulas(:,1),particulas(:,2));
        pause(0.2);
    end
end

if ((funcion==1) || (funcion==2))
    [minimo pos]=min(y_n);
    fprintf('el minimo encontrado es: %d \n',minimo);
    fprintf('En la posici�n: %d \n',particulas(pos));
else
    [minimo pos]=min(particula_z);
    fprintf('el minimo encontrado es: %d \n',min(minimo));
    fprintf('En la posici�n x: %d y:%d \n',particulas(pos,1),particulas(pos,2));
end