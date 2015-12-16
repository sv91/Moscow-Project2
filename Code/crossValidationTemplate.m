% template script to be used to apply k-fold cross validation to a model

initWorkSpace;

ber_te_model_feature = [];
ber_tr_model_feature = [];

for i = 1:kfold_nb
    X_train = X_feature(find(training(kfold, i)), :);
    X_test = X_feature(find(test(kfold, i)), :);
    y_train = y_type(find(training(kfold, i)), :);
    y_test = y_type(find(test(kfold, i)), :);
    
    % fit model
    b_model_feature %= fitting_function;
    
    % predict test and training data
    y_te_model_feature %= apply_b_model_feature;
    y_tr_model_feature %= apply_b_model_feature;
    
    % get test and training error
    ber_te_model_feature(i) = BER(2, y_test, y_te_model_feature);
    ber_tr_model_feature(i) = BER(2, y_train, y_tr_model_feature);
        
    fprintf('Testing error: %.2f%%\n', ber_te_model_feature(i) * 100 );
    fprintf('Training error: %.2f%%\n\n', ber_tr_model_feature(i) * 100 );
    
end

fprintf('\nTesting mean: %.2f%%\n', mean(ber_te_model_feature) * 100 );
fprintf('Testing var: %.2f%%\n\n', var(ber_te_model_feature) * 100 );

fprintf('Training mean: %.2f%%\n', mean(ber_tr_model_feature) * 100 );
fprintf('Training var: %.2f%%\n\n', var(ber_tr_model_feature) * 100 );
