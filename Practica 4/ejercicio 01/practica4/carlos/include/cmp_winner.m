function [hit] = cmp_winner(y,yd)
    y_aux = -ones(length(y),1);
    [~,idx] = max(y);
    y_aux(idx) = 1;
    hit = isequal(y_aux,yd);
end

