# Moscow-Project2

Git repository for the second project of the "Patern Classification and Machine Learning" class for the group "Moscow". 

# TODO-List
- [x] Preliminaries
	- [x] Code for getting 2-class dataset 
	
- [ ] Baseline Classification: Logistic Regression
	- [x] Basic logRegression for binary classification
	- [ ] Multinomial logistic regression (using mnrfit)
	- [ ] Multi-class classification implementation: One vs Rest

- [ ] Feature Processing (test and validate with baseline)
	- [x] HOG: see if we can reduce the # of features (dim. reduction or removing)
	- [ ] Overfeat: understand better the features
	- [ ] Overfeat: get kmeans & pca versions
	- [ ] Combine HOG+CNN features, shuffle and PCA that

- [x] Model validation: implement 10-fold Cross-Validation (and test it on baseline)


# Summary & results of the experiences

| Method        			| Tr err | Tr var | Te err | Te var | 
|:--------------------------------------|:------:|:------:|:------:|:------:|

| Bin Baseline Logistic Regression	| x      | x      | x      | x      |
| Bin SVM Linear Kernel 		| x      | x      | x      | x      |
| Bin SVM Gaussian Kernel 		| x      | x      | x      | x      |
| Bin kNN or kmeans 			| x      | x      | x      | x      |

| Mult Multinomial Log. Regression 	| x      | x      | x      | x      |
| Mult SVM Linear Kernel 		| x      | x      | x      | x      |
| Mult SVM Gaussian Kernel 		| x      | x      | x      | x      |
| Mult kNN or kmeans 			| x      | x      | x      | x      |

| RedMult Multinomial Log. Regression	| x      | x      | x      | x      |
| RedMult SVM Linear Kernel 		| x      | x      | x      | x      |
| RedMult SVM Gaussian Kernel 		| x      | x      | x      | x      |
| RedMult kNN or kmeans 		| x      | x      | x      | x      |


