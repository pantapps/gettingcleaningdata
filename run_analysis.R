# Getting and Cleaning Data Course Project - Coursera
# Eduardo Garcia 2016

# This script performs the following tasks required in the Final Assignment of 
# the Getting and Cleaning Data Course:
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Source of project data: 

# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# IMPORTANT: To run this script the project data must have been downloaded and 
# extracted into the script directory.

library(dplyr)
library(data.table)


# Reading training and test data

tabSubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
tabActivityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
tabFeaturesTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

tabSubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
tabActivityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
tabFeaturesTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


# 1. Merging the training and the test sets to create one data set

tabSubject <- rbind(tabSubjectTrain, tabSubjectTest)
tabActivity <- rbind(tabActivityTrain, tabActivityTest)
tabFeatures <- rbind(tabFeaturesTrain, tabFeaturesTest)

colnames(tabSubject) <- "Subject"
colnames(tabActivity) <- "Activity"

tabFeatureNames <- read.table("UCI HAR Dataset/features.txt")
colnames(tabFeatures) <- t(tabFeatureNames[2])

tabData <- cbind(tabFeatures, tabActivity, tabSubject)


# 2. Extracting only the measurements on the mean and standard deviation for
#    each measurement

meanSTDColumns <- grep("mean\\(\\)|std\\(\\)", names(tabData), ignore.case = TRUE)

subjectColumn <- which(colnames(tabData) == "Subject")
activityColumn <- which(colnames(tabData) == "Activity")

dataColumns <- c(meanSTDColumns, subjectColumn, activityColumn)
tabData <- subset(tabData, select = dataColumns)


# 3. Uses descriptive activity names to name the activities in the data set

tabActivityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
tabActivityLabels <- as.character(tabActivityLabels[,2])
tabData$Activity <- tabActivityLabels[tabData$Activity]


# 4. Appropriately labels the data set with descriptive variable names. 

#head(str(tabData),2)

names(tabData)<-gsub("[(][)]", "", names(tabData))
names(tabData)<-gsub("Acc", "Accelerometer", names(tabData))
names(tabData)<-gsub("Gyro", "Gyroscope", names(tabData))
names(tabData)<-gsub("BodyBody", "Body", names(tabData))
names(tabData)<-gsub("Mag", "Magnitude", names(tabData))
names(tabData)<-gsub("^t", "Time", names(tabData))
names(tabData)<-gsub("^f", "Frequency", names(tabData))
names(tabData)<-gsub("tBody", "TimeBody", names(tabData))
names(tabData)<-gsub("-mean", "Mean", names(tabData), ignore.case = TRUE)
names(tabData)<-gsub("-std", "STD", names(tabData), ignore.case = TRUE)
names(tabData)<-gsub("-freq", "Frequency", names(tabData), ignore.case = TRUE)
names(tabData)<-gsub("angle", "Angle", names(tabData))
names(tabData)<-gsub("gravity", "Gravity", names(tabData))

#head(str(tabData),6)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

tabData$Subject <- as.factor(tabData$Subject)
tabData <- data.table(tabData)

tidyData <- aggregate(. ~Subject + Activity, tabData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

write.table(tidyData, file = "TidyData.txt", row.names = FALSE)