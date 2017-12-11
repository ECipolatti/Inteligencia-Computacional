function [datos_originales,datos_ordenados]=OrdenaMerval(nombre)
    datos_originales=csvread(nombre);
    cant_datos=length(datos_originales);
    datos=datos_originales;
    n=floor(cant_datos/5);

    for i=1:cant_datos-5
        datos_ordenados(i,:)=datos(i:i+5);
    end
end


    