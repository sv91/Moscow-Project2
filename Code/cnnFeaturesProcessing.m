initWorkSpace;

X = reduceCNN(X_cnn,20);

% L2 normalization
X_cnn_l2norm = norm(X);
X_cnn_l2normalized = X / X_cnn_l2norm;

% center and standardize values for PCA
X_cnn_mean = mean(X_cnn_l2normalized);
X_cnn_std = std(X_cnn_l2normalized);
X_cnn_stdized = (X_cnn_l2normalized - repmat(X_cnn_mean, [X_N 1]));
X_cnn_stdized = X_cnn_stdized ./ repmat(X_cnn_std, [X_N 1]);

% compute the PCA and retain PCs that explain most of the variance 
[pca_coeff_cnn, ~, ~, ~, pca_explained_cnn, pca_mu_cnn] = pca(X_cnn_stdized, 'Centered', false); % no centering, done before

% plot of the variance explained
pca_explained_cnn_cum = cumsum(pca_explained_cnn);
plot(pca_explained_cnn_cum);

% get pca coeffs and apply them
% 99.0005% of the variance explained with #PCs=1528
% 95.0070% of the variance explained with #PCs=684
% 90.0082% of the variance explained with #PCs=410
nb_pcs_cnn=684;
selected_coeffs_cnn = pca_coeff_cnn(:, 1:nb_pcs_cnn);
X_cnn_pca = X_cnn_stdized * selected_coeffs_cnn;

% whiten and L2-normalize again
[X_cnn_whitened, ~, ~, X_cnn_w_mat] = mat_whitening(X_cnn_pca);
%Xwh = X*whMat;
X_cnn_l2norm2 = norm(X_cnn_whitened);
X_cnn_l2normalized2 = X_cnn_whitened / X_cnn_l2norm2;

% save the processed features in file
X_cnn_p = X_cnn_l2normalized2;
save('/Data/train/train.X_cnn_p.mat', 'X_cnn_p');
