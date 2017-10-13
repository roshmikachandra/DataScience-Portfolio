# Clean Adult data set
library(dummies)

# Read the data file into a data frame
filePath = ''
fileName = 'adult.test'
fileToWrite = 'adultTest.csv'
fileCSV = read.csv(paste(filePath, fileName, sep = ''),header=FALSE)
fileDataFrame = data.frame(fileCSV)
# Select columns from the data frame, and add dummy variables
fileDataFrame = fileDataFrame[-c(3,14)]

columnsForDummy = c(2,3,5:9,13)
for(column in columnsForDummy) {
  fileDataFrame = cbind(fileDataFrame, dummy(fileDataFrame[,column],sep='_'))
  # Drop the last dummy column to avoid multicollinearity
  if(nlevels(fileDataFrame[,column]) > 1) {
    fileDataFrame = fileDataFrame[-ncol(fileDataFrame)]
  }
}

fileDataFrame = fileDataFrame[-columnsForDummy]
str(fileDataFrame)

# Normalize the numeric columns  by their maximum value
fileDataFrame[,1] = fileDataFrame[,1] / max(fileDataFrame[,1])
fileDataFrame[,2] = fileDataFrame[,2] / max(fileDataFrame[,2])
fileDataFrame[,3] = fileDataFrame[,3] / max(fileDataFrame[,3])
fileDataFrame[,4] = fileDataFrame[,4] / max(fileDataFrame[,4])
fileDataFrame[,5] = fileDataFrame[,5] / max(fileDataFrame[,5])

# Write the cleaned data to file
names(fileDataFrame) = NULL
write.csv(fileDataFrame, file= fileToWrite, row.names = FALSE)




