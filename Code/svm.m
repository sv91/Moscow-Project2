initWorkSpace;

ber_te_svm = [];
ber_tr_svm = [];

%kernel_type = 'gaussian';
kernel_type = 'linear';
C = 1;
set = X_hog_p;
%C = 0.1;
%set = X_cnn_p;

for i = 1:kfold_nb
    
    % get datasets
    X_train = set(find(training(kfold, i)), :);
    X_test = set(find(test(kfold, i)), :);
    y_train = y_bin(find(training(kfold, i)), :);
    y_test = y_bin(find(test(kfold, i)), :);
    
    % fit model
    b_svm = fitcsvm(X_train, y_train, 'KernelFunction', kernel_type, ...
    'ClassNames', [0,1], 'Verbose', 1, ... 
    'BoxConstraint', C, 'KernelScale', 'auto');
    
    % predict test and training data
    y_te_svm = predict(b_svm, X_test);
    y_tr_svm = predict(b_svm, X_train);
    
    % get test and training error
    ber_te_svm(i) = BER(2, y_test, y_te_svm);
    ber_tr_svm(i) = BER(2, y_train, y_tr_svm);
        
    fprintf('Testing error: %.2f%%\n', ber_te_svm(i) * 100 );
    fprintf('Training error: %.2f%%\n\n', ber_tr_svm(i) * 100 );
    
end


fprintf('\nTesting mean: %.2f%%\n', mean(ber_te_svm) * 100 );
fprintf('Testing var: %.2f%%\n\n', var(ber_te_svm) * 100 );

fprintf('Training mean: %.2f%%\n', mean(ber_tr_svm) * 100 );
fprintf('Training var: %.2f%%\n\n', var(ber_tr_svm) * 100 );
