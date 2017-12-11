function [confusion,pos,neg,recall,esp,p,n,a,F,G]=matriz_confusion(M,valorP)
    %supongo que en M tengo en la peniltima columna, lo que dio el
    %clasificador, y en la ultima lo que debería haber dado
    %valorP es el valor de un acierto
    [n,~]=size(M);
    TP=0; %Verdadero positivo
    TN=0; %verdadero negativo
    FP=0; %Falso positivo
    FN=0; %Falso negativo
    for i=1:n
        if (M(i,end-1)==M(i,end))
            if (M(i,end-1)==valorP)
                TP = TP+1;
            else
                TN = TN +1;
            end
        else
            if (M(i,end-1)==valorP)
                FP = FP +1;
            else
                FN = FN +1;
            end
        end
    end
    confusion = [TP FN;FP TN];
    pos = TP + FN;      %casos positivos
    neg = FP + TN;      %casos negativos
    recall = TP/pos;    %sensibilidad (true positive rate)
    esp = TN/neg;       %especificidad (true negative rate)
    p = TP/(TP+FP);     %Precisión (positive predictive value)
    n = TN/(TN+FN);     %(negative predictive value)
    a = (TP+TN)/n;      %accuracy
    F= (2*TP)/(2*TP+FP+FN); %F1 Score/F Measure
    G= sqrt(recall*p);  %G-measure
end