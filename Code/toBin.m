function y_bin = toBin( y, i, val )
% toBin create a binary classification from a multiclass classification
% by keeping the i-th label as positive and all the rest negative.
% val is used to defined the value of the i-th label. By default it is 1.
if or(nargin < 3,val > 0)
	g = 1;
	b = 0;
else
    g = 0;
    b = 1;
end

y_bin = y;
for j = 1:size(y)
    if y_bin(j) == i
        y_bin(j) = g;
    else
        y_bin(j) = b;
    end
end
    