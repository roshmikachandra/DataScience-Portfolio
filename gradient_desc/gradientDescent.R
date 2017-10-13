# Gradient descent code using logistic regression on training data
# Recall: Logistic function log(1 + exp( - y * <x,\beta>))
# Gradient: -y * x * exp(-y * <x,\beta>) * (1 / (1 +  exp( - y * <x,\beta>)))

# Read the data file into a data frame
filePath = ''
fileName = 'adultTrain.csv'
fileModel = 'modelGradDesc.csv'
fileCSV = read.csv(paste(filePath, fileName, sep = ''),header=FALSE)
fileDataFrame = data.frame(fileCSV)

# Compute gradient
gradient = function(x, y, beta) {
  innerProd = x %*% beta
  expValue = exp(- y * innerProd)
  grad = - (y * expValue  / (1+ expValue)) * x
  return(grad)
}

# Perform gradient descent
beta = rep(0, ncol(fileDataFrame)-1)
for(i in 1:nrow(fileDataFrame)) {
  learningRate = 1/ sqrt(i)
  vec = as.numeric(fileDataFrame[i,]) 
  x = vec[1:length(vec)-1]
  y=vec[length(vec)]
  y = 2 * y -1 # Convert from {0, 1} to {-1, 1}
  beta = beta - learningRate * gradient(x,y,beta)
}
beta = data.frame(beta)
names(beta)= NULL
write.csv(beta, file=paste(filePath,fileModel,sep=''), row.names = FALSE)
