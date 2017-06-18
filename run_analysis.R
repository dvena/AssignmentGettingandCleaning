# Assignment for Getting and Cleaning Data

# Set filepath relative to working directory
fpath <- "./GettingAndCleaningData/Assignment/UCI HAR Dataset/"

# Read all data
## Read feature names and clean them
ftrNames <- as.matrix(fread(paste0(fpath, "features.txt"), select = c(2)))
ftrNames <- gsub("[()]", "", ftrNames)

## Read subject id
idtrain <- read.table(paste0(fpath,"train/", "subject_train.txt"), col.names = c("id"))
idtest <- read.table(paste0(fpath, "test/", "subject_test.txt"), col.names = c("id"))

## Read files
Xtrain <- read.table(paste0(fpath, "train/", "X_train.txt"), col.names = ftrNames)
ytrain <- read.table(paste0(fpath, "train/", "y_train.txt"), col.names = c("activity"))
Xtest <- read.table(paste0(fpath, "test/", "X_test.txt"), col.names = ftrNames)
ytest <- read.table(paste0(fpath, "test/", "y_test.txt"), col.names = c("activity"))

# Merge all data
# merge id, X, and y data for train and test
trainData <- cbind(idtrain, ytrain, Xtrain)
testData <- cbind(idtest, ytest, Xtest)

# merge training and test data
data <- rbind(trainData, testData)

# Convert label numbers to label names
data$activity <- factor(data$activity, levels=c(1,2,3,4,5,6), 
               labels = c("walking", "walking_upstairs", "walking_downstairs",
                          "sitting", "standing", "laying"))

# Create dataset with only mean and standard deviation data
# Procedure is out of order from assignment but this involved less typing and
# clearer code so I went ahead with it. 

dataMnStd <- data[, c("id", "activity", grep("\\.mean$", names(data), value=TRUE), 
                 grep("\\.std$", names(data), value=TRUE),
                 grep("\\.mean\\.", names(data), value=TRUE),
                 grep("\\.std\\.", names(data), value=TRUE))]
varnames <- names(dataMnStd)[3:length(dataMnStd)]
# Create independent tidy data set that stores averages for each variable 
# and subject

dataSummary <- aggregate(dataMnStd[, 3:length(dataMnStd)], 
                         list(id = dataMnStd[, "id"], 
                              activity = dataMnStd[, "activity"]), 
                         FUN = "mean")

dataSummary <- dataSummary[order(dataSummary$id, dataSummary$activity), ]

