function [ BER ] = BER( C, y, yHat )
%BER Computes the Balanced Error Rate
%   The balanced error rate is the average of the errors on each class
%   Assumes classes are 1 to C

% cast input to int, as this is a classification problem
y = int8(y);
yHat = int8(yHat);

% range 0-based if binary, 1-based otherwise
if C == 2 
    range = 0:1;
else
    range = 1:C;
end

BER = 0;

for c = range
    currentClassMask = ones(length(y), 1) .* c;
    currentClassMask = currentClassMask == y;
    
    errors = y ~= yHat;
    classErrors = currentClassMask .* errors;
    
    BER = BER + sum(classErrors) / sum(currentClassMask);
end

BER = BER / C;