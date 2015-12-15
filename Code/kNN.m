function W = kNN(X, k, type, w)
%   K-Nearest Neighbors algorithm.
%
%   M: Training data.
%   k: Number of neighbors
%   type: Type of kNN. '0' for normal, '1' for mutual.
%   w: '0' for an unweighted graph,'1' for normal.

if nargin < 4
    w = 1;
end

[~,N] = size(X);

% Preallocate memory
a = zeros(1, k * N);
b = zeros(1, k * N);
c = zeros(1, k * N);

for i = 1:N
    norm_x = sum(X(i,:).^2,2);
    norm_X = sum(X.^2,2);
    inner_prods = X(i,:) * X';
    dist = bsxfun(@plus,norm_X',bsxfun(@minus,norm_x,2*inner_prods));
    
    % Sort row by distance
    [x, y] = sort(dist, 'ascend');
    
    % Save indices and value of the k 
    a(1, (i-1)*k+1:i*k) = i;
    b(1, (i-1)*k+1:i*k) = y(1:k);
    c(1, (i-1)*k+1:i*k) = x(1:k);
end

W = sparse(a, b, c, N, N);

if type == 1
    W = min(W, W');
else
    W = max(W, W');
end


% Unweighted graph
if w == 0
    W = (W ~= 0);
end

end