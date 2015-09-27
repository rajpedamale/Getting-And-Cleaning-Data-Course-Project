library(reshape2)

filename <- "UCI HAR Dataset.zip"

# Get the data
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
    unzip(filename) 
}  

# Load activity labels
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity.labels[,2] <- as.character(activity.labels[,2])

# Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Define what needs to be extracted - The data on mean and standard deviation
features.extracted <- grep(".*mean.*|.*std.*", features[,2])
features.extracted.names <- features[features.extracted,2]
features.extracted.names = gsub('-mean', 'Mean', features.extracted.names)
features.extracted.names = gsub('-std', 'Std', features.extracted.names)
features.extracted.names <- gsub('[-()]', '', features.extracted.names)

# Load the train and test datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features.extracted]
train.activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train.subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train.subjects, train.activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features.extracted]
test.activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test.subjects, test.activities, test)

# Merge datasets and add labels
tidy.data <- rbind(train, test)
colnames(tidy.data) <- c("subject", "activity", features.extracted.names)

# Turn activities and subjects into factors
tidy.data$activity <- factor(tidy.data$activity, levels = activity.labels[,1], labels = activity.labels[,2])
tidy.data$subject <- as.factor(tidy.data$subject)

# Reshape data to get averages for each activity and each subject
tidy.data.melted <- melt(tidy.data, id = c("subject", "activity"))
tidy.data.mean <- dcast(tidy.data.melted, subject + activity ~ variable, mean)

write.table(tidy.data.mean, "tidy-data.txt", row.names = FALSE, quote = FALSE)
