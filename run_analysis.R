#' # Getting and Cleaning Data Course Project
#'
#' This script performs the data preparation required for the "Getting and Cleaning Data" course project.
#'
#' ## Process Flow:
#' 1. Downloads and extracts the UCI HAR Dataset if not already present
#' 2. Loads feature names and activity labels
#' 3. Reads training and test data sets
#' 4. Merges training and test data into a single data set
#' 5. Extracts only measurements on mean and standard deviation
#' 6. Uses descriptive activity names for activities in the data set
#' 7. Appropriately labels the data set with descriptive variable names
#' 8. Creates a tidy data set with the average of each variable for each activity and subject
#' 9. Writes the tidy data set to a file
#'
#' ## Dependencies:
#' - dplyr: for data manipulation
#' - data.table: for efficient data handling
#'
#' ## Output:
#' - tidy_data.txt: A tidy data set with the average of each variable for each activity and subject

library(dplyr)
library(data.table)


if (!file.exists("./data")) {
    dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "./data/ProjectFiles.zip")
unzip("./data/ProjectFiles.zip", exdir = "./data")


featureNames <- read.table("./data/UCI HAR Dataset/features.txt")
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

colnames(features) <- t(featureNames[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features, activity, subject)

colnames(features) <- featureNames$V2


completeData <- cbind(features, activity, subject)


meanStdColumns <- grep("mean\\(\\)|std\\(\\)", featureNames$V2)
selectedColumns <- c(meanStdColumns, 562, 563)

extractedData <- completeData %>%
    select(all_of(selectedColumns))


extractedData <- extractedData %>%
    mutate(Activity = factor(Activity,
        levels = activityLabels$V1,
        labels = activityLabels$V2
    ))


names(extractedData) <- gsub("^t", "Time", names(extractedData))
names(extractedData) <- gsub("^f", "Frequency", names(extractedData))
names(extractedData) <- gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData) <- gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData) <- gsub("Mag", "Magnitude", names(extractedData))
names(extractedData) <- gsub("BodyBody", "Body", names(extractedData))
names(extractedData) <- gsub("-mean\\(\\)", "Mean", names(extractedData))
names(extractedData) <- gsub("-std\\(\\)", "StdDev", names(extractedData))


tidyData <- extractedData %>%
    group_by(Subject, Activity) %>%
    summarize_all(mean)


write.table(tidyData, "tidy_data.txt", row.names = FALSE)
