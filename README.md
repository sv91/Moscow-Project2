# Moscow-Project2

Git repository for the second project of the "Patern Classification and Machine Learning" class for the group "Moscow". 

# TODO-List
- [ ] Preliminaries
	- [ ] Code for getting 2-class dataset 
	
- [ ] Baseline Classification: Logistic Regression
	- [ ] Basic logRegression for binary classification
	- [ ] Multi-class classification implementation: https://en.wikipedia.org/wiki/Multiclass_classification
		- [ ] OvR
		- [ ] OvO
	- [ ] Reduce multiclass to binary classification 

- [ ] Feature Processing (test and validate with baseline)
	- [ ] HOG: see if we can reduce the # of features (dim. reduction or removing)
	- [ ] Overfeat: understand better the features
	- [ ] Overfeat: see what kind of processing we can apply 

- [ ] Model validation implementation
	- [ ] Implement 10-fold Cross-Validation (and test it on baseline)
	- [ ] Bias-Variance tradeoff computation ? (need to estimation over/under fit)

- [ ] Models: for each get the cross-validation, and run: binary classification, multi-class classification, reduce multiclass to binary
	- [ ] Optimized logRegression (penalized variant ?)
	- [ ] SVM Implementation (linear + gaussian kernel)
	- [ ] kNN or K-mean Implementation (maybe not? doesnt seem appropriate) ?
	- [ ] Stochastic gradient descent + momentum using mini-batch ?


