initWorkSpace;


%% --browse through the images and look at labels
for i=1:10
    clf();

    % load img
    img = imread( sprintf('Data/train/imgs/train%05d.jpg', i) );

    % show img
    imshow(img);

    title(strcat('Label: ', labelName(y(i))));

    pause;  % wait for key,??
end

%% -- Example: split half and half into train/test, use HOG features
fprintf('Splitting into train/test..\n');

Tr = [];
Te = [];

% NOTE: you should do this randomly! and k-fold!
Tr.idxs = 1:2:size(X_hog,1);
Tr.X = X_hog(Tr.idxs,:);
Tr.y = y(Tr.idxs);

Te.idxs = 2:2:size(X_hog,1);
Te.X = X_hog(Te.idxs,:);
Te.y = y(Te.idxs);

%%
fprintf('Training simple neural network..\n');

rng(8339);  % fix seed, this    NN may be very sensitive to initialization

% setup NN. The first layer needs to have number of features neurons,
%  and the last layer the number of classes (here four).
nn = nnsetup([size(Tr.X,2) 10 4]);
opts.numepochs =  20;   %  Number of full sweeps through data
opts.batchsize = 100;  %  Take a mean gradient step over this many samples

% if == 1 => plots trainin error as the NN is trained
opts.plot               = 1;

nn.learningRate = 2;

% this neural network implementation requires number of samples to be a
% multiple of batchsize, so we remove some for this to be true.
numSampToUse = opts.batchsize * floor( size(Tr.X) / opts.batchsize);
Tr.X = Tr.X(1:numSampToUse,:);
Tr.y = Tr.y(1:numSampToUse);

% normalize data
[Tr.normX, mu, sigma] = zscore(Tr.X); % train, get mu and std

% prepare labels for NN
LL = [1*(Tr.y == 1), ...
      1*(Tr.y == 2), ...
      1*(Tr.y == 3), ...
      1*(Tr.y == 4) ];  % first column, p(y=1)
                        % second column, p(y=2), etc

[nn, L] = nntrain(nn, Tr.normX, LL, opts);


Te.normX = normalize(Te.X, mu, sigma);  % normalize test data

% to get the scores we need to do nnff (feed-forward)
%  see for example nnpredict().
% (This is a weird thing of this toolbox)
nn.testing = 1;
nn = nnff(nn, Te.normX, zeros(size(Te.normX,1), nn.size(end)));
nn.testing = 0;


% predict on the test set
nnPred = nn.a{end};

% get the most likely class
[~,classVote] = max(nnPred,[],2);

% get overall error [NOTE!! this is not the BER, you have to write the code
%                    to compute the BER!]
%predErr = sum( classVote ~= Te.y ) / length(Te.y);
predErr = BER(4, Te.y, classVote);

fprintf('\nTesting error: %.2f%%\n\n', predErr * 100 );


%% visualize samples and their predictions (test set)
figure;
for i=20:30  % just 10 of them, though there are thousands
    clf();

    img = imread( sprintf('Data/train/imgs/train%05d.jpg', Te.idxs(i)) );
    imshow(img);


    % show if it is classified as pos or neg, and true label
    title(strcat('Label: ', labelName(y(Te.idxs(i))),', Pred: ', labelName(classVote(i))));

    pause;  % wait for keydo that then,??
end
