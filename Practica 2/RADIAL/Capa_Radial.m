function [Y] = Capa_Radial (x,mu, neu_capa_radial)
    Y = zeros(1,neu_capa_radial);
    for i=1:neu_capa_radial
        Y(i) = gaussiana(x,mu(i),1);
    end
end

