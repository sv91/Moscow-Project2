clear all;

% refs for toolbox
%https://lvdmaaten.github.io/drtoolbox/
%http://dmlab8.csie.ntust.edu.tw/#kstattoolbox.html KPCA

% get deterministic result
rng(3493752176); 

% add toolboxes to path
addpath(genpath('Code/Toolbox/piotr_toolbox/'));
addpath(genpath('Code/Toolbox/DeepLearnToolbox-master/'));
addpath(genpath('Code/Toolbox/drtoolbox/'));

% load dataset and convert to double precision
load Data/train/train.y.mat;
load Data/train/train.X_hog_p.mat; % processed features
load Data/train/train.X_cnn_p.mat; % processed features batch=200,k=20
load Data/train/train.X_cnn.mat; % original features
load Data/train/train.X_hog.mat; 
X_cnn = double(X_cnn);
X_hog = double(X_hog);

% get binary classification
y_bin = toBin( y, 4, 0 );

% constants
X_N = 6000;
X_D_hog = 5408;
X_D_cnn = 36865;
kfold_nb = 10;

% k-fold partition
kfold = cvpartition(X_N, 'KFold', kfold_nb);

fprintf('Init done...\n');
