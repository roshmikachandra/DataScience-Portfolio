# Train and test Logistic Regression (with cross-validation and l2-regularization)
# Read the data file into a data frame
library(glmnet)
library(ROCR)
filePath = ''
fileTrainName = 'adultTrain.csv'
fileTrainCSV = read.csv(paste(filePath, fileTrainName, sep = ''),header=FALSE)
fileTrainDataFrame = data.frame(fileTrainCSV)

fileTestName = 'adultTest.csv'
fileTestCSV = read.csv(paste(filePath, fileTrainName, sep = ''),header=FALSE)
fileTestDataFrame = data.frame(fileTestCSV)

# Create feature matrices
featureTrainMatrix = fileTrainDataFrame[,1:ncol(fileTrainDataFrame)-1]
responseTrain = fileTrainDataFrame[,ncol(fileTrainDataFrame)]

featureTestMatrix = fileTestDataFrame[,1:ncol(fileTestDataFrame)-1]
responseTest = fileTestDataFrame[,ncol(fileTestDataFrame)]

# Train the model using k fold cross validation
k= 5
cvModel= cv.glmnet(data.matrix(featureTrainMatrix),responseTrain, family = "binomial", alpha=0, nfolds = k)
fitModel= glmnet(data.matrix(featureTrainMatrix),responseTrain, family = "binomial", alpha = 0,lambda = cvModel$lambda.min)

# Predict on the test data with the model
predictModel= predict(fitModel,data.matrix(featureTestMatrix),type="response")

pr1= prediction(predictModel,responseTest)
prf= performance(pr1, measure = "tpr", x.measure = "fpr")

# Compute AUC 
aucValue= performance(pr1, measure = "auc")
aucValue= aucValue@y.values[[1]]

print(aucValue)
