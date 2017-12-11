function [ s ] = sigmoid(v)
  s=zeros(size(v));
  for i=1:length(v)  
    s(i) = 2/(1+exp(-v(i))) - 1;
  end
end
