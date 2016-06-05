# Getting and Cleaning Data Course Project
# run_analysis.R
#
# Purpose:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.
#
# Requirements:
# 1. Project dataset in current working directory "UCI HAR Dataset"
#    The download_data.R script can be used to download and unzip data set. 
# 2. Packages dplyr, data.table, tidyr
#
# Usage:
# Set working directory to getting-cleaning-data directory
# source("run_analysis.R")
#

# Initialize prerequisites
datasetPath <- "./UCI HAR Dataset"

library(dplyr)

# Read labels and features
activityLabels <- tbl_df(read.table(file.path(datasetPath, "activity_labels.txt")))
names(activityLabels) <- c("activityNumber", "activityName")

features <- tbl_df(read.table(file.path(datasetPath, "features.txt")))
names(features) <- c("featureNumber", "featureName")


# Read and merge training and test subjects (7352 + 2947 = 10299 rows x 1 column)
# Subject files: Each row identifies the subject who performed the activity for
# each window sample. Its range is from 1 to 30.
trainingSubjects <- tbl_df(read.table(file.path(datasetPath, "train", "subject_train.txt")))
testSubjects <- tbl_df(read.table(file.path(datasetPath, "test", "subject_test.txt")))
mergedSubjects <- rbind(trainingSubjects, testSubjects) 

# Update column names and clean up
names(mergedSubjects) <- "subject"
rm("trainingSubjects")
rm("testSubjects")


# Read and merge training and test labels (7352 + 2947 = 10299 rows x 1 column)
# Labels: Each row contains the activity label. Its range is from 1 to 6 (see also activityLabels)
trainingLabels <- tbl_df(read.table(file.path(datasetPath, "train", "y_train.txt"))) # Note: lowercase y
testLabels <- tbl_df(read.table(file.path(datasetPath, "test", "y_test.txt"))) # Note: lowercase y
mergedLabels <- rbind(trainingLabels, testLabels) 

# Update column names and clean up
names(mergedLabels) <- "activityNumber"
rm("trainingLabels")
rm("testLabels")


# Read and merge training and test data (7352 + 2947 = 10299 rows x 561 columns)
# Set: Each row contains a list of 561 features (see also featureLabels)
trainingSet <- tbl_df(read.table(file.path(datasetPath, "train", "X_train.txt"))) # Note: uppercase X
testSet <- tbl_df(read.table(file.path(datasetPath, "test", "X_test.txt"))) # Note: uppercase X
mergedSet <- rbind(trainingSet, testSet)

# Update column names and clean up
names(mergedSet) <- features$featureName
rm("trainingSet")
rm("testSet")


# Extract only measurements on mean and std deviation for each measurement
# 10299 rows x 79 columns (includes mean frequency components)
# meanStdFeatures <- grep("mean|std", features$featureName)
# mergedSet <- mergedSet[, meanStdFeatures]

# 10299 rows x 66 columns (excludes mean of frequency components)
meanStdFeatures <- grep("mean\\(\\)|std\\(\\)", features$featureName)
mergedSet <- mergedSet[, meanStdFeatures]

# Add columns for subject, activityNumber, and an activityName placeholder
mergedSet <- cbind(mergedSubjects, mergedLabels, data.frame(activityName=""), mergedSet)

# Use descriptive activity names
mergedSet$activityName <- activityLabels[mergedSet$activityNumber,]$activityName

# Remove activity number column
mergedSet$activityNumber <- NULL

# Appropriately label the data set with descriptive variable names.
names(mergedSet) <- tolower(names(mergedSet)) 							# all lowercase
names(mergedSet) <- gsub("activityname", "activity", names(mergedSet))	# "activity" is sufficient
names(mergedSet) <- gsub("-", "_", names(mergedSet))					# all underscores
names(mergedSet) <- gsub("\\(\\)", "", names(mergedSet))				# remove parentheses
names(mergedSet) <- gsub("^t", "time_", names(mergedSet))				# t stands for time
names(mergedSet) <- gsub("^f", "frequency_", names(mergedSet))			# f stands for frequency
names(mergedSet) <- gsub("_body", "_body_", names(mergedSet))			# separate with underscore
names(mergedSet) <- gsub("_body_body", "_body_", names(mergedSet))		# remove duplicates
names(mergedSet) <- gsub("_gravity", "_gravity_", names(mergedSet))		# separate with underscore
names(mergedSet) <- gsub("_acc", "_accelerometer_", names(mergedSet))	# acc stands for accelerometer
names(mergedSet) <- gsub("_gyro", "_gyroscope_", names(mergedSet))		# gyro stands for gyroscope
names(mergedSet) <- gsub("jerkmag", "jerk_mag", names(mergedSet))		# separate with underscore
names(mergedSet) <- gsub("mag", "magnitude", names(mergedSet))			# mag stands for magnitude
names(mergedSet) <- gsub("__", "_", names(mergedSet))					# remove duplicates

# Sort column names alphabetically
mergedSet <- mergedSet[, order(names(mergedSet))]

# Make 'subject' the first column again
mergedSet <- mergedSet[, c("subject", setdiff(names(mergedSet), "subject"))] 

# Save merged set
write.table(mergedSet, file = "merged.txt")


# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
summarySet <- group_by(mergedSet, subject, activity) %>% 
	summarize_each(funs(mean)) %>% 
	arrange(subject, activity)
	
# Save summary set
write.table(summarySet, file = "summary.txt")

