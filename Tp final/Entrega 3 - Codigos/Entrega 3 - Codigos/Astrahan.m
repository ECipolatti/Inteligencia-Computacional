function [ Seed ] = Astrahan( k, data )
% k=4;
% data = csvread('OR_trn.csv');

[n, m] = size(data);
cant_seed = k;
[~,indmayor]=max(data);
[~,indmenor]=min(data);



Dist=rand(k,1)*.1*norm(data(indmayor,:)-data(indmenor,:),2);
Dist= abs(Dist);
Dist= sort(Dist,'Descend');
Seed=zeros(cant_seed,m);

for s=1:cant_seed
    vec_a_eliminar=[];
    [n, m] = size(data);
    D = zeros(n,1);
    for i=1:n
        for j=1:n
            if norm(data(i,:)-data(j,:),2)<Dist(s)
                D(i) = D(i) + norm(data(i,:)-data(j,:),2);
            end
        end
    end
    [~,ind]=max(D);
    Seed(s,:)=data(ind,:);
    for j=1:n
        if norm(data(ind,:)-data(j,:),2) < Dist(s)
            vec_a_eliminar = [vec_a_eliminar j]
        end
    end
    vec_a_eliminar = sort(vec_a_eliminar,'descend');
    for rem=1:length(vec_a_eliminar)
        data(vec_a_eliminar(rem),:)=[];
    end
    
end
end