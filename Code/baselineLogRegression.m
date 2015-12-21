initWorkSpace;

ber_te_logRegBaseline = [];
ber_tr_logRegBaseline = [];

set = X_hog_p;

for i = 1:kfold_nb
    
    % get datasets
    X_train = set(find(training(kfold, i)), :);
    X_test = set(find(test(kfold, i)), :);
    y_train = y_bin(find(training(kfold, i)), :);
    y_test = y_bin(find(test(kfold, i)), :);
    
    % fit model
    b_logRegBaseline = glmfit(X_train, single(y_train), 'binomial', 'link', 'logit');
    
    % predict test and training data
    y_te_logRegBaseline = glmval(b_logRegBaseline, X_test , 'logit');
    y_tr_logRegBaseline = glmval(b_logRegBaseline, X_train , 'logit');
    
    % get test and training error
    ber_te_logRegBaseline(i) = BER(2, y_test, y_te_logRegBaseline);
    ber_tr_logRegBaseline(i) = BER(2, y_train, y_tr_logRegBaseline);
        
    fprintf('Testing error: %.2f%%\n', ber_te_logRegBaseline(i) * 100 );
    fprintf('Training error: %.2f%%\n\n', ber_tr_logRegBaseline(i) * 100 );
    
end

fprintf('\nTesting mean: %.2f%%\n', mean(ber_te_logRegBaseline) * 100 );
fprintf('Testing var: %.2f%%\n\n', var(ber_te_logRegBaseline) * 100 );

fprintf('Training mean: %.2f%%\n', mean(ber_tr_logRegBaseline) * 100 );
fprintf('Training var: %.2f%%\n\n', var(ber_tr_logRegBaseline) * 100 );
