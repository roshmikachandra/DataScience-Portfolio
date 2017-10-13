# Test model using logistic regression
library(ROCR)

# Prediction function
predict = function(x,beta) {
  print(length(x))
  print(length(beta))
  pred = 1.0 / (1 +exp(-(x %*% beta)))
  return(pred)
}

# Read the model and the test data file into data frames
filePath = ''
fileModel = 'modelGradDesc.csv'
fileTestData = 'adultTest.csv'

fileCSV = read.csv(paste(filePath, fileModel, sep= ''),header=FALSE)
modelDF = data.frame(fileCSV)

fileCSV = read.csv(paste(filePath, fileTestData, sep= ''),header=FALSE)
testDF = data.frame(fileCSV)

# Create test data for prediction
featureMatrix = data.matrix(testDF[,1:ncol(testDF)-1])
trueLabel = testDF[,ncol(testDF)]
model = modelDF[,1]

# Perform model prediction
predictions = c()
for(i in 1:nrow(featureMatrix)) {
  currentPrediction = predict(featureMatrix[i,], model)
  predictions = c(predictions, c(currentPrediction))
}

#Compute AUC
pr1= prediction(predictions, trueLabel)
prf= performance(pr1, measure = "tpr", x.measure = "fpr")
plot(prf)
#formula for computing auc
auc= performance(pr1, measure = "auc")
auc= auc@y.values[[1]]
print(auc)

                
