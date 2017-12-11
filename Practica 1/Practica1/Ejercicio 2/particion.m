function [ DTrn , DTst ] = particion(nro_part, por_trn, Data)

    filas_Data = length(Data);
    col_Data = length(Data(1,:));
    nro_datos_trn = round(length(Data)*por_trn/100); %total datos segun el entrenamiento
    DTrn=zeros(nro_datos_trn,col_Data, 1,nro_part); %vector de matrices de entrenamiento
    DTst=zeros((filas_Data-nro_datos_trn),col_Data, 1, nro_part); %vector de matrices de prueba

    for i=1:nro_part
        ind = randperm(length(Data)); %indices random de Data
        DTrn(:,:,1,i) = Data(ind(1:nro_datos_trn),:);
        DTst(:,:,1,i) = Data(ind(nro_datos_trn+1:length(ind)),:);
    end

end

