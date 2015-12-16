initWorkSpace;

ber_te_logRegBaseline_hog = [];
ber_tr_logRegBaseline_hog = [];

for i = 1:kfold_nb
    X_train = X_hog(find(training(kfold, i)), :);
    X_test = X_hog(find(test(kfold, i)), :);
    y_train = y_bin(find(training(kfold, i)), :);
    y_test = y_bin(find(test(kfold, i)), :);
    
    % fit model
    b_logRegBaseline_hog = glmfit(X_train, single(y_train), 'binomial', 'link', 'logit');
    
    % predict test and training data
    y_te_logRegBaseline_hog = glmval(b_logRegBaseline_hog, X_test , 'logit');
    y_tr_logRegBaseline_hog = glmval(b_logRegBaseline_hog, X_train , 'logit');
    
    % get test and training error
    ber_te_logRegBaseline_hog(i) = BER(2, y_test, y_te_logRegBaseline_hog);
    ber_tr_logRegBaseline_hog(i) = BER(2, y_train, y_tr_logRegBaseline_hog);
        
    fprintf('Testing error: %.2f%%\n', ber_te_logRegBaseline_hog(i) * 100 );
    fprintf('Training error: %.2f%%\n\n', ber_tr_logRegBaseline_hog(i) * 100 );
    
end

fprintf('\nTesting mean: %.2f%%\n', mean(ber_te_logRegBaseline_hog) * 100 );
fprintf('Testing var: %.2f%%\n\n', var(ber_te_logRegBaseline_hog) * 100 );

fprintf('Training mean: %.2f%%\n', mean(ber_tr_logRegBaseline_hog) * 100 );
fprintf('Training var: %.2f%%\n\n', var(ber_tr_logRegBaseline_hog) * 100 );
