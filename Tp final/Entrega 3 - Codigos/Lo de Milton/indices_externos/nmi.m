function n = nmi(x,y)
  n = mutualinfo(x,y) / sqrt(entropy(x) * entropy(y));
end
