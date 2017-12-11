function graficar(W)
%     scatter(X(2),X(3));
    x=linspace(-2,2,50);    
    y=W(1)/W(3)-W(2)/W(3)*x;
    hold on;
    pause(.1);
    plot(x,y);
    axis([-2 2 -2 2]);
end