function [y] = equal(a,b)
    if length(a) ~= length(b)
        error('Inconsistent vector sizes');
    end
    
    % si da 0 significa que al menos un elemento de a es distinto del de b
    y = sum(a == b) == length(b);

end

