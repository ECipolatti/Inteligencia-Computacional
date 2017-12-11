function [ Data ] = Crea_Patrones(Data_Original)
    [n,~] = size(Data_Original);
    cant_patrones = floor(n/6);
    Data = zeros(cant_patrones,6);
    
    %Data(1,:)=Data_Original(1:6);
    
%     % Primera forma
%     j=1;
%     for i=1:cant_patrones
%         Data(i,:) = Data_Original(j:j+5);
%         if (n-(j+5)<6)
%             break
%         end 
%         j=j+5;
%     end
    
    %Segunda forma
    for i=1:n-5
        Data(i,:) = Data_Original(i:i+5);
    end    
end

