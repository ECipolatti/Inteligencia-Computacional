function [hit_counter,CM] = mlp_test_cm(test_data,RN,w,n_inputs,n_outputs,phi,c)
    % definición del método de comparación para las salidas. si n_ouputs == 1
    % alcanza con comparar el signo y clasificar clase A = +1 y clase B -1. si
    % n_ouputs es mayor a 1, hará falta aplicar el criterio 'winner takes it
    % all', es decir, asignar +1 a la mayor salida y -1 al resto
    if n_outputs == 1
        cmp_func = @(y,yd) cmp_signo(y,yd);
    else
        cmp_func = @(y,yd) cmp_winner(y,yd);
    end

    hit_counter = 0;
    capa_salida=length(RN); % Cantidad de capas de la RN
    y=cell(size(RN));       % Salidas de cada capa
    
    CM = zeros(n_outputs);

    E = size(test_data,1);    %Cantidad de ejemplos para test
    for i_e=1:E
        x = [-1; test_data(i_e,1:n_inputs)'];
        yd = test_data(i_e,n_inputs+1:end);
        
        %% Propagacion hacia adelante
        y{1}=phi(w{1}*x,c);

        for i=2:capa_salida
            y{i}=phi(w{i}*[-1;y{i-1}],c);
        end
        
        y_aux = -ones(length(y{capa_salida}),1);
        [~,idx] = max(y{capa_salida});
        y_aux(idx) = 1;
        
        j_cm = ocrclass(y_aux);
        i_cm = ocrclass(yd');
        
        CM(i_cm,j_cm) = CM(i_cm,j_cm) + 1;
        
        if(cmp_func(y{capa_salida},yd'))
            hit_counter=hit_counter+1;
        end
    end
end

