function [S] = reproduction(P,F,mrate,crprob)
    % reproducción
    % P:        individuos de la población actual
    % F:        progenitores elegidos por selección natural
    % mrate:    tasa de mutaciones (entre 0 y 1) -> genes mutados por población
    % crprob:   probabilidad de que se produzcan cruzas
    S = gcross(P,F,crprob);
    S = mutation(S,mrate);
end
