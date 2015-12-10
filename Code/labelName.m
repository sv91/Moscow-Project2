function label = labelName( l )
%labelName show the label name corresponding to the label number for an
%   easier view.

switch l
case 1
    label = 'Plane';
case 2
    label = 'Car';
case 3
    label = 'Horse';
otherwise
    label = 'Other';
end
