function bestC = optimizedKMeans(X)

X = X';
minSum = Inf;
bestC = [];

for i= 5:20
    fprintf('Iteration %d',i)
    [~,C,sumd] = kmeans(X,i,'Display','iter','MaxIter',30);
    if sum(sumd)< minSum
        minSum =sum(sumd);
        bestC = C;
    end
end