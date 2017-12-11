y_out = zeros(size(test_data,1),3);
hit_counter = 0;
y=cell(size(RN));       % Salidas de cada capa
for i_e = 1 : E
    x = [-1; test_data(i_e,1:n_inputs)'];
    yd = test_data(i_e,end);

    %% Propagacion hacia adelante
    y{1}=phi(w{1}*x,c);

    for i=2:capa_salida
        y{i}=phi(w{i}*[-1;y{i-1}],c);
    end

    aux = signo(y{capa_salida});
    if(aux ~= test_data(i_e,end))
        y_out(i_e,:) = [x(2),x(3),2];
    else
        y_out(i_e,:) = [x(2),x(3),aux];
        hit_counter=hit_counter+1;
    end
end

hit_perc = hit_counter/E*100;
fprintf('Porcentaje de acierto (TEST)  %.2f \n',hit_perc);
epochs=epochs-1;

gscatter(y_out(:,1),y_out(:,2),y_out(:,3),'gbr','oox');

figure;
plot(H(1:(max_ep-epochs)));
xlabel('Epocas');
ylabel('Porcentaje de acierto');