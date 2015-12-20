function X_reduced = reduceCNN(X,k)

% X:    X_cnn to reduce
% type: type of reduction:
%                   * 1: kNN
%                   * 2: k-means
%                   * 3: kNN with CNN triggered or not
%                   * 4: k-means with CNN triggered or not
%                   * 5: kNN with CNN deteministic
%                   * 6: k-means with CNN deteministic
% k:    argument k for kNN or k-means

[N,D] = size(X);

% If not 0, we set to 1.
% for i = 1:N
% 	for j =1:D
%         if tempX(i,j) > 0
%             tempX(i,j) = 1;
%         end
%     end
% end
% discared = [];
% append(discared, 0)
% c = 1;
% for i = 1:D
%     fprintf('Iteration %d ',i);
%     fprintf('Discared %d \n',size(discared));
%     if ismember(i,discared)
%         break
%     else
%         temp = X(:,i);
%         for j =i+1:D
%             if isequal(tempX(:,i),tempX(:,j))
%                 fprintf('YES');
%                 temp = temp + X(:,j);
%                 append(discared, j)
%             end
%         end
%         X_reduced(:,c) = temp;
%         c = c + 1;
%     end

batch_size = 200;
batch_number = 2*(floor(D/batch_size));
X_reduced = zeros(N,batch_number*k);

for i=1:batch_number-1
    fprintf('Iteration %d \n', i );
    [~,~,~,d] = kmeans(X(:,1+batch_size/2*(i-1):batch_size/2*(i+1)),k);

    X_reduced(:,1+k*(i-1):k*(i)) = d;
end
    [~,~,~,d] = kmeans(X(:,1+batch_size/2*(batch_number-1):end),k);
    X_reduced(:,1+k*(batch_number-1):k*(batch_number)) = d;
    [~,~,~,d] = kmeans(cat(2,X(:,1+batch_size/2*(batch_number):end),X(:,1:batch_size/2)),k);
    X_reduced(:,1+k*(batch_number):k*(batch_number+1)) = d;
end
