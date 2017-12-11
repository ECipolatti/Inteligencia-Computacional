function [ p ] = purity( Cluster )
    % Devuelve la pureza que hay de un cluster, tomando el que mas se repite y
    % dividiendo por la cantidad de elementos del cluster
    % Cluster = [1 1 1; 1 1 3; 1 1 1; 1 1 1; 3 3 3]
%     [n, ~] = size(Cluster);
%     cont = 0;
%     for i = 1 : n
%         cantidad = 0;
%         for j = 1 : n
%            if isequal(Cluster(i, :), Cluster(j,:))
%                cantidad = cantidad + 1;
%            end
%         end
%         if (cantidad > cont)
%             cont = cantidad;
%         end
%     end
%     p = cont / n;
    
    % --------------------- MARIO -------------------
    [n, ~] = size(Cluster);
    cont = 0;
    [~, ~, ci] = unique(Cluster);
    for i = 1 : ( max(ci) )
        aux = length(find(ci, i));
        if (aux > cont)
            cont = aux;
        end
    end
    p = cont / n;
end