clear all;

% add toolboxes to path
addpath(genpath('Code/Toolbox/piotr_toolbox/'));
addpath(genpath('Code/Toolbox/DeepLearnToolbox-master/'));

% load dataset
load Data/train/train.y.mat;
load Data/train/train.X_cnn.mat;
load Data/train/train.X_hog.mat;

% get binary classification
y_bin = y;
y_bin(y_bin==4) = 0;
y_bin(y_bin==2) = 1;
y_bin(y_bin==3) = 1;

% constants
X_N = 6000;
X_D_hog = 5408;
X_D_cnn = 36865;
kfold_nb = 10;

% k-fold partition
rng(3493752176); % get deterministic result
kfold = cvpartition(X_N, 'KFold', kfold_nb);
