function [ var_por_dim ] = Var(k, cellClases, dim)
    var_por_dim = zeros(k,dim);
    for i=1:k %clases
        for j=1:dim
            %var_por_dim(i,j) = var(cellClases{i}(:,j)); 
            var_por_dim(i,j) = 80*80; 
        end
    end
end

