## Getting and Cleaning Data Course Project
##
## @author: Said HEZOUANI <shezouani@gmail.com>

##
# Load data
##

# Check if data rep exists
if(!file.exists("./Dataset")){
        stop("Dataset folder not found!")
}

# Load features list

features <- read.table(
        "./Dataset/features.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("id","label")
)

# Load activities list

activities <- read.table(
        "./Dataset/activity_labels.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("id","label")
)

# Load test raw data

XTestData <- read.table(
        "./Dataset/test/X_test.txt", 
        sep = "",
        header = FALSE, 
        col.names = features[["label"]],
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

yTestData <- read.table(
        "./Dataset/test/y_test.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("activity"),
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

subjTestData <- read.table(
        "./Dataset/test/subject_test.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("subject"),
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

# Load train raw data

XTrainData <- read.table(
        "./Dataset/train/X_train.txt", 
        sep = "",
        header = FALSE, 
        col.names = features[["label"]],
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

yTrainData <- read.table(
        "./Dataset/train/y_train.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("activity"),
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

subjTrainData <- read.table(
        "./Dataset/train/subject_train.txt", 
        sep = "",
        header = FALSE, 
        col.names = c("subject"),
        na.strings=c("N\\A"),
        colClasses = "numeric"
)

##
# 1. Merges the training and the test sets to create one data set.
##

# Merging Test data tables in one table
mergedTestData <- cbind(subjTestData,yTestData,XTestData)

# Merging Train data tables in one table
mergedTrainData <- cbind(subjTrainData,yTrainData,XTrainData)

# Merging Test & Train data
mergedData <- rbind(mergedTestData,mergedTrainData)

##
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
##

library(dplyr)

meanStdCols <- select(
        mergedData,
        subject,
        activity,
        contains("mean"),
        contains("std")
)

##
# 3. Uses descriptive activity names to name the activities 
# in the data set
##

meanStdCols$activity <- sapply(
        meanStdCols$activity, 
        function(elt) {
                label <- as.character(activities[elt,"label"])
                return(label)
        }
)

##
# 4. Appropriately labels the data set with descriptive variable names. 
## 

# NOTE : colnames are already appropriately set

##
# 5. From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity 
# and each subject.
##

tidyData <- meanStdCols %>% group_by(subject,activity) %>% summarise_each(funs(mean))


## 
# Saving tidyData to text file
##

write.table(tidyData,"tidy_data.txt",row.names = FALSE )