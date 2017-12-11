function [ seleccionados ] = Ventana( fac_reduccion , Genotipos, type_fitnes, tasa )
    [n, ~]= size(Genotipos);
    
    % Ordeno Segun Fitnes
    [Vec_Fitnes] = Fitnes_Matrix( Genotipos, type_fitnes, tasa );
    [~, Indices] = sort(Vec_Fitnes);
    
  
    ind = round(rand()*n);
    seleccionados(1,:) = Genotipos(Indices(ind),:);
    
    ventana = n;
    i=2;
    while(ventana > fac_reduccion)
        ventana = ventana - fac_reduccion;
        ind = round(rand()*(ventana-1))+1;
        seleccionados(i,:) = Genotipos(Indices(ind),:);
        i = i+1;
    end

end

