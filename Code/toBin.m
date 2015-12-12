function y_bin = toBin( y, i )
% toBin create a binary classification from a multiclass classification
% by keeping the i-th label as positive and all the rest negative.
y_bin = y;
for j = 1:size(y)
    if y_bin(j) == i
        y_bin(j) = 1;
    else
        y_bin(j) = 0;
    end
end
    