##Initialize the program by loading required libraries for the project and clearing the workspace
#load reshape2 r library
library(reshape2)
# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

filename <- "getdata_dataset.zip"

## First step is to download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

## Second step is to load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

### Third step is to extract only the data on mean and standard deviation
meas_reqd <- grep(".*mean.*|.*std.*", features[,2])
meas_reqd.names <- features[meas_reqd,2]
meas_reqd.names = gsub('-mean', 'Mean', meas_reqd.names)
meas_reqd.names = gsub('-std', 'Std', meas_reqd.names)
meas_reqd.names <- gsub('[-()]', '', meas_reqd.names)


#### Load the datasets in descriptive variable called train, trainActivities, trainSubjects
train <- read.table("UCI HAR Dataset/train/X_train.txt")[meas_reqd]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

#### Load the datasets in descriptive variable called test, testActivities, testSubjects
test <- read.table("UCI HAR Dataset/test/X_test.txt")[meas_reqd]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

#### Now merge train and test  datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", meas_reqd.names)

### From the allData data set, creating a second, independent tidy data set with the average of each variable for ### each activity and each subject
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)


### Final step is to write output on the file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)