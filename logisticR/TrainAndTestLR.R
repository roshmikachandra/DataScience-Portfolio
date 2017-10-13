#Train and test simple logistic regression followed by different performance 
#measurements ofmodel (model accuracy,ROC,AUC,TPR,TNR,FPR,FNR, Precison and Recall)

#Read train and test data file into dataframe
filePath = ''
fileTrain = 'adultTrain.csv'
fileTest = 'adultTest.csv'
readTrain = read.csv(paste(filePath,fileTrain, sep = ''), header = FALSE)
readTest = read.csv(paste(filePath,fileTest, sep = ''), header = FALSE)
trainDF = data.frame(readTrain)
testDF = data.frame(readTest)

#Create feature matrix and response vector on train data
featureMatrix = trainDF[,1:ncol(trainDF)-1]
response = trainDF[,ncol(trainDF)]

#model fitting
fitModel = glm(response~ data.matrix(featureMatrix), family = binomial (link = 'logit'))
summary(fitModel)
anova(fitModel, test="Chisq")

#creating feature matrix and response on test data
featureMatrixTest = testDF[,1:ncol(testDF)-1]
responseTest = testDF[,ncol(testDF)]

#model prediction on test data
fittedResults = predict(fitModel,featureMatrixTest, type = 'response')
#creating a threshold for the predicted response
threshold = 0.5
fittedResultsBinary = ifelse(fittedResults>threshold, 1,0)

#computing misclassification error and accuracy

misClasError = mean(fittedResults != responseTest)

print(paste('Accuracy',1-misClasError))

#plot ROC 
library(ROCR)
fittedResults = predict(fitModel,featureMatrixTest, type = 'response')
pr = prediction(fittedResults, responseTest)
prf = performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

#compute AUC
AUC = performance(pr, measure = "auc")
AUC <- AUC@y.values[[1]]
print(AUC)

#compute FPR,FNR,TPR,TNR

TP = ifelse(fittedResultsBinary == responseTest,1,0)*responseTest
TN = ifelse(fittedResultsBinary == responseTest,1,0)*(1-responseTest)
FP = ifelse(fittedResultsBinary != responseTest, 1,0)*(1-responseTest)
FN = ifelse(fittedResultsBinary != responseTest,1,0)*responseTest

TPR = mean(TP)
TNR = mean(TN)
FPR = mean(FP)
FNR = mean(FN)

#compute precision and recall
precision = TPR/(TPR+FPR)
recall = TPR/(TPR+FNR)
print(paste('precision : ', precision, 'recall : ', recall))


