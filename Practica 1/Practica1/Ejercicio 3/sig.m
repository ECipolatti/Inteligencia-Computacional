function[Y] = sig(X,b)
	Y= 2 ./ (1 + exp(-b * X)) - 1;
end