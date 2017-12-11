function [ ] = Graficar( type, M, X)
    n = size(M,1);
    %     X = linspace(X(1),X(2),X(3));
    [ muA ] = matrixMember( type, M, X );
%     subplot(3,1,1);
    color = ['y' 'm' 'c' 'r' 'g' 'b' 'k'];
    for i = 1:n
        Y(:,i) = muA(:,i);
        h = plot(X,Y(:,i), color(i));
        set(h,'LineWidth',2);
        axis([min(X) max(X) -0.5 1.5]);
        hold on
    end

    title('Conjuntos');
    xlabel('x');
    ylabel('y');
    hold off;
   
end

