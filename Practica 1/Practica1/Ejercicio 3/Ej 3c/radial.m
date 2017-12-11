function [ D ] = radial( Data )

[n m] = size(Data);
D = zeros(n,2);

media_x1 = mean(Data(:,1));
media_x2 = mean(Data(:,2));

for i=1:n
    r = sqrt( (Data(i,1) - media_x1)^2 + (Data(i,2) - media_x2)^2 );
    D(i,1) = r;
    D(i,2) = Data(i,3);
end

end

