function [X,Y] = graphSOM(W)
    clf;
    [H,L] = size(W);
    hold on;
    X = zeros(H,L);           % coordenadas x para las ubicaciones de las neuronas (puntos)
    Y = zeros(H,L);           % coordenadas x para las ubicaciones de las neuronas (puntos)
    for i = 1 : H
        for j = 1 : L
%             k = k+1;
            X(i,j) = W{i,j}(1);   % almacena la coordenada x
            Y(i,j) = W{i,j}(2);   % almacena la coordenada y
            
%             % se grafican las líneas verticales (el if controla que no se salga de rango)
%             if i < H
%                 plot([W{i,j}(1) W{i+1,j}(1)],[W{i,j}(2) W{i+1,j}(2)],'r');
%             end
% 
%             % se grafican las líneas horizontales (el if controla que no se salga de rango)
%             if j < L
%                 plot([W{i,j}(1) W{i,j+1}(1)],[W{i,j}(2) W{i,j+1}(2)],'r');
%             end
        end
    end

    % se grafica un punto por cada neurona (dispersión)
    surf(X,Y,ones(H,L),'FaceAlpha',0,'edgecolor','r');
    scatter3(reshape(X,1,H*L),reshape(Y,1,H*L),ones(1,H*L),450,'.k');
    hold off;
    drawnow;
end

