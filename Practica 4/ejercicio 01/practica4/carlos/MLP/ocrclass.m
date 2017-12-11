function [class] = ocrclass(y)
    % devuelve la clase de dígito que es
    [~,class] = max(y == 1);
end

