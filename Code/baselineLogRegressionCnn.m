initWorkSpace;

ber_te_logRegBaseline_cnn = [];
ber_tr_logRegBaseline_cnn = [];

for i = 1:kfold_nb
    X_train = X_cnn_p(find(training(kfold, i)), :);
    X_test = X_cnn_p(find(test(kfold, i)), :);
    y_train = y_bin(find(training(kfold, i)), :);
    y_test = y_bin(find(test(kfold, i)), :);
    
    % fit model
    b_logRegBaseline_cnn = glmfit(X_train, single(y_train), 'binomial', 'link', 'logit');
    
    % predict test and training data
    y_te_logRegBaseline_cnn = glmval(b_logRegBaseline_cnn, X_test , 'logit');
    y_tr_logRegBaseline_cnn = glmval(b_logRegBaseline_cnn, X_train , 'logit');
    
    % get test and training error
    ber_te_logRegBaseline_cnn(i) = BER(2, y_test, y_te_logRegBaseline_cnn);
    ber_tr_logRegBaseline_cnn(i) = BER(2, y_train, y_tr_logRegBaseline_cnn);
        
    fprintf('Testing error: %.2f%%\n', ber_te_logRegBaseline_cnn(i) * 100 );
    fprintf('Training error: %.2f%%\n\n', ber_tr_logRegBaseline_cnn(i) * 100 );
    
end

fprintf('\nTesting mean: %.2f%%\n', mean(ber_te_logRegBaseline_cnn) * 100 );
fprintf('Testing var: %.2f%%\n\n', var(ber_te_logRegBaseline_cnn) * 100 );

fprintf('Training mean: %.2f%%\n', mean(ber_tr_logRegBaseline_cnn) * 100 );
fprintf('Training var: %.2f%%\n\n', var(ber_tr_logRegBaseline_cnn) * 100 );
