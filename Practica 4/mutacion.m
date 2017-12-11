function [mut]=mutacion(M,pc,p)
% M = Matriz de genes
% p = probabilidad de mutar el gen;
[n,m] = size(M);
mut = M;
for i = 1:n
    r = rand()*100;
    if r <= pc
        for j = 1:m
            r = rand()*100;
            if r <= p
                if M(i,j)
                    mut(i,j) = 0;
                else
                    mut(i,j) = 1;
                end
            end
        end
    end
end
end
