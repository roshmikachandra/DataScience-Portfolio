#Iris data clean and create train and test data set
#Recall normalize function: (x-min(x))/(max(x)-min(x))

#read iris data file into dataframe
filePath = ''
fileName = 'iris.data.txt'
readFile = read.table(paste(filePath, fileName, sep = ''),sep = ',', header = FALSE)
originalFile = data.frame(readFile)

#shuffling the data as the original data was homogenous
set.seed(9850)
randomNum = runif(nrow(originalFile))
originalFile = originalFile[order(randomNum),]

#create normalize function to normalize iris data
normalize = function(x){
  normValue =  ((x - min(x))/(max(x) - min(x)))
  return(normValue)
}

#apply normalize function on iris dataset
fileDF_norm = as.data.frame(lapply(originalFile[,c(1,2,3,4)],normalize))
summary(fileDF_norm)

#create train and test data set on normalized data without the label
index = sample(1:nrow(fileDF_norm), size = 0.2*nrow(fileDF_norm))
trainData = fileDF_norm[-index,]
testData = fileDF_norm[index,]


#create train and test data set on actual data with only label
#Recall dim(testDataResponse): will give the dimension of the datafile
indexOriginalData = sample(1:nrow(originalFile), size = 0.2*nrow(originalFile))
trainDataResponse = originalFile[-indexOriginalData,]
trainDataResponse = trainDataResponse[,ncol(trainDataResponse)]
testDataResponse = originalFile[indexOriginalData,]
testDataResponse = testDataResponse[, ncol(testDataResponse)]

#install package 'class' and run knn algorithm
#Recall optimal k = sqrt(total no of observation in original data)
install.packages("class")
library(class)
modelKnn = knn(train = trainData, test = testData, cl = trainDataResponse, k = 5 )

#evaluating model performance with package gmodels
table(testDataResponse, modelKnn)

#interpretation of model performance: testdataresponse shows sentosa 8 times and our model 
#predicted setosa correctly 3 times.testdataresponse shows versicolor 14 times 
#and our model predicted versicolor correctly 8 times.
#testdataresponse shows virginica 8 times and our model predicted virginica 
#correctly 4 times.
#TPR(sentosa)= (3/8)*100
#TPR(versicolor)= (8/14)*100
#TPR(virginica)= (4/8)*100










