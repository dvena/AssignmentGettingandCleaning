# README file for run_analysis

The following code does the following:
- Generates a filepath variable to the data to be loaded
- Feature names are loaded from the file location
- Loads training data and training activity labels (X_train.txt and y_train.txt, repectively)
- Loads test data and test activity labels (X_test.txt and y_test.txt)
- Training data (subject ID, ytrain, Xtrain) are merged along their columns
- Test data (subject ID, ytest, Xtest) are merged along their columns
- Merged training and test data are merged along their rows to make a complete data set
- Activity labels are converted to a factor and given appropriate factor labels

- A new data set is generated (dataMsStd) that only includes the mean and standard deviation values of each feature (total of 66 variables not included id and activity labels)
- Then lastly, a summary dataset is generated that generates the mean of each variable for each subject in each activity label