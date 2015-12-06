function [ BER ] = BER( C, y, yHat )
%BER Computes the Balanced Error Rate
%   The balanced error rate is the average of the errors on each class

BER = 0;

for c = 1:C
    currentClassMask = ones(length(y), 1) .* c;
    currentClassMask = currentClassMask == y;
    
    errors = y ~= yHat;
    classErrors = currentClassMask .* errors;
    
    BER = BER + sum(classErrors) / sum(currentClassMask);
end

BER = BER / C;