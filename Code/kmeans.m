function Proto = kmeans(X, K, max_iter)
% K-means algorithm.
%   X: Training data.
%   K: Number of clusters.
%   max_iter: Maximal number of iteration

% Size of the training data.
[N,D] = size(X);

% Initializing the prototypes
Proto = 0.1 * randn(K,D);

for i = 1:max_iter
    fprintf('K-means iteration %d / %d\n', i, iter);
        
    % Computing the norm of the prototypes
    norm = 0.5 * sum(Proto.^2,2);
        
    % optimize the cluster assignments, minimize square distance,
    % maximize similarity
    [~,labels] = max(bsxfun(@minus,Proto*X',norm));
        
    % optimal assignments as indicator matrix
    S = sparse(1:N,labels,1,N,K,N); 
    
    % final features after i-th iteration, take their mean
    Proto = bsxfun(@rdivide,S' * X,sum(S,1)');
    
    % remove empty clusters
    bad_index = (counts == 0);
    Proto(bad_index,:) = 0;
end

end