function grafica(X, Yd, Y)

    subplot(2,1,1)
    title('Datos originales');
    k = X(Yd(:)>0,:);
    scatter(k(:,2),k(:,3),15,'k');
    hold on
    r = X(Yd(:)<0,:);
    scatter(r(:,2),r(:,3),15,'r');
    
    subplot(2,1,2)
    title('Datos Clasificados');
    k = X(Y(:)>0,:);
    scatter(k(:,2),k(:,3),15,'k');
    hold on
    r = X(Y(:)<0,:);
    scatter(r(:,2),r(:,3),15,'r');

end

