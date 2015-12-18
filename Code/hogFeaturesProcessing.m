initWorkSpace;

% L2 normalization for each variable
X_hog_l2norms = sqrt(sum(X_hog .^2));
X_hog_l2normalized = bsxfun(@rdivide, X_hog, X_hog_l2norms);

% center and standardize values for PCA
X_hog_mean = mean(X_hog_l2normalized);
X_hog_std = std(X_hog_l2normalized);
X_hog_stdized = (X_hog_l2normalized - repmat(X_hog_mean, [X_N 1]));
X_hog_stdized = X_hog_stdized ./ repmat(X_hog_std, [X_N 1]);

% compute the PCA and retain PCs that explain most of the variance 
[pca_coeff_hog, ~, ~, ~, pca_explained_hog, pca_mu_hog] = ...
    pca(X_hog_stdized, 'Centered', false); % no centering, done before

% plot of the variance explained
pca_explained_hog_cum = cumsum(pca_explained_hog);
plot(pca_explained_hog_cum);

% get pca coeffs and apply them
% 99.0005% of the variance explained with #PCs=1528
% 95.0070% of the variance explained with #PCs=684
% 90.0082% of the variance explained with #PCs=410
nb_pcs_hog=684;
selected_coeffs_hog = pca_coeff_hog(:, 1:nb_pcs_hog);
X_hog_pca = X_hog_stdized * selected_coeffs_hog;

% whiten and L2-normalize again
[X_hog_whitened, ~, ~, X_hog_w_mat] = mat_whitening(X_hog_pca);
%Xwh = X*whMat;
% L2 normalization for each variable
X_hog_l2norms2 = sqrt(sum(X_hog_whitened .^2));
X_hog_l2normalized2 = bsxfun(@rdivide, X_hog_whitened, X_hog_l2norms2);

% save the processed features in file
X_hog_p = X_hog_l2normalized2;
save('Data/train/train.X_hog_p.mat', 'X_hog_p');


% CONCVERTED TO DOUBLE
%coeff = pca(X) returns the principal component coefficients, also known as loadings, for the n-by-p data matrix X. Rows of X correspond to observations and columns correspond to variables. The coefficient matrix is p-by-p. Each column of coeff contains coefficients for one principal component, and the columns are in descending order of component variance. By default, pca centers the data and uses the singular value decomposition (SVD) algorithm.
%Principal component scores are the representations of X in the principal component space. Rows of score correspond to observations, and columns correspond to components.

% apply without method:
%>> B * COEFF
%>> B = zscore(A)
%ref:http://matlabdatamining.blogspot.ch/2010/02/principal-components-analysis.html
% we have to apply the very same transofmration to the other data
% > AMean = mean(A)
% >> AStd = std(A)
% >> B = (A - repmat(AMean,[n 1])) ./ repmat(AStd,[n 1])

%> Hi all,
% >
% > If I apply PCA to a dataset and just take the N largest principal components, do I >have to center new data first before multiplying with the principal components?
% 
% Yes
% 
% >Why?
% 
% The PCA is based on the covariance matrix which is formed from
% centered data.
% 
% >If I have to center the new data first, what mean do I have to subtract?
% > The mean from the first data set where I initially applied PCA?!?
% 
% Yes.



%[U,S,V] = svd(cov(X_hog));
%[U,S,V] = svd(cov(X_cnn));

%plot(cumsum(diag(S)));
% TODO do that on L2 normalized
% compute the PCAs and get vars ; note: the Xs should be transposed with
% this pca implementation (piotr)s
% [U_hog, mu_hog, vars_hog] = pca(X_hog');
% [U_cnn, mu_cnn, vars_cnn] = pca(X_cnn');
% 
% % plot the cumulative variances/eigenvalues
% plot(cumsum(vars_hog));
% figure;
% plot(cumsum(vars_cnn));


% test pca/svd reduction to see impact
% we have 13*13*32 array
% we can have a matrix 169*32 this is still representative (just flattening
% the grid)
% 
% reshaped = reshape(X_hog(58,:), 169, 32);
% %reshaped(2, :) == squeeze(train_hog(2, 1, :))' % this is true
% reshaped = reshaped';
% % now let's try pca to reduce the 32 to sth smaller
% [U,mu,vars] = pca(reshaped);
% [ Yk, Xhat, avsq ] = pcaApply( reshaped, U, mu, 8 )

% put in report: dim chosen accoring do av sqrerror + image of
% reconstructed images