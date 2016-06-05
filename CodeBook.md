# Code Book

This file describes the variables, data, and transformations performed to prepare the required datasets.

## Data Source

The original data set was downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Description of original data: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## Original Data Introduction

The provided data is the result of experiments that have been carried out with 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone on the waist.

Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.

The script `run_analysis.R` processes the following files in the provided data set:

* `activity_labels.txt` - a two column list of activity keys and labels (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)

* `features.txt` - a two column list of feature keys and labels (tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, etc)

* `subject_train.txt` and `subject_test.txt` - a numeric index representing the participant in the range from 1-30 per measurement. The training group produced 7352 measurements (rows), the test group 2947 measurements. 

* `y_train.txt` and `y_test.txt` - a numeric index representing the activity in the range from 1-6 per measurement. Like the subject list above, there are 7352 measurements (rows) in the training group, and 2947 in the test group.

* `X_train.txt` and `X_test.txt` - the actual data and measurements, a list of 561 variables (columns) per measurement. Like subject and activity lists above, there are 7352 measurements (rows) in the training group, and 2947 in the test group.

Other files in the provided data set were not relevant for this assignment.


## Variables

The 561 measured variables are described in more detail in `features_info.txt`. For this project only the standard deviation and mean values were relevant. This reduced the number of variables to 66 features.

The features in the original data set were abbreviated as follows:

1. leading `t` or `f` for 'time' or 'frequency' domain
2. `Body` for body movement signals
3. `Gravity` for gravity acceleration signals
4. `Acc` for accelerometer measurements
5. `Gyro` for gyroscope measurements
6. `Jerk` for jerk signals
7. `Mag` for magnitude
8. `mean()` and `std()` for mean and standard deviation
9. `X`, `Y`, `Z` used to denote 3-axial signals in X, Y, Z directions

Examples:

* `tBodyAcc-mean()-X`
* `tBodyAcc-mean()-Y`
* `tBodyAcc-mean()-Z`
* `fBodyBodyGyroJerkMag-std()`

## Transformations

### 1. Merge training and test groups

The measurements in the 'train' and 'test' files are merged to `mergedSubjects`, `mergedLabels`, and `mergedSet`. After merging, each of these tables contain a total number of 7352 + 2947 = 10299 measurements.

In this step the variable names were also initialized as follows:

- `mergedSubjects` - subject
- `mergedLabels` - activityNumber
- `mergedSet` - the feature names provided in `features.txt`

### 2. Extract only measurements on mean and standard deviation

The table is reduced to columns that contain the strings `mean()` and `std()` in the name, resulting in a table with 66 variables.

### 3. Add columns for subjects and activities, and use descriptive activity names

This step adds to `mergedSet` the subject in `mergedSubjects` and the activity in `mergedLabels`. 

The activity index in `mergedLabels` is also transformed to one of six activity names found in `activity_labels.txt`.

The resulting table now contains a new `subject` and `activityName` column.

### 4. Appropriately label data set with descriptive variable names

This step performs the following string replacements on the column names:

- Change all names all lowercase
- Replace all `-` to `_`
- Remove all parentheses
- Change leading `t` to `time`
- Change leading `f` to `frequency`
- Change `acc` to `accelerometer`
- Change `gyro` to `gyroscope`
- Change `mag` to `magnitude`
- Separate all words with an underscore

The column order is also sorted alphabetically so the names are returned as follows:

* `subject`
* `activity`                                        
* `frequency_body_accelerometer_jerk_magnitude_mean`
* `frequency_body_accelerometer_jerk_magnitude_std`
* `frequency_body_accelerometer_jerk_mean_x`
* `frequency_body_accelerometer_jerk_mean_y`       
* `frequency_body_accelerometer_jerk_mean_z`
* `frequency_body_accelerometer_jerk_std_x`         
* `frequency_body_accelerometer_jerk_std_y`
* `frequency_body_accelerometer_jerk_std_z`         
* `frequency_body_accelerometer_magnitude_mean`
* `frequency_body_accelerometer_magnitude_std`      
* `frequency_body_accelerometer_mean_x`
* `frequency_body_accelerometer_mean_y`             
* `frequency_body_accelerometer_mean_z`
* `frequency_body_accelerometer_std_x`              
* `frequency_body_accelerometer_std_y`
* `frequency_body_accelerometer_std_z`              
* `frequency_body_gyroscope_jerk_magnitude_mean`
* `frequency_body_gyroscope_jerk_magnitude_std`     
* `frequency_body_gyroscope_magnitude_mean`
* `frequency_body_gyroscope_magnitude_std`          
* `frequency_body_gyroscope_mean_x`
* `frequency_body_gyroscope_mean_y`                 
* `frequency_body_gyroscope_mean_z`
* `frequency_body_gyroscope_std_x`                  
* `frequency_body_gyroscope_std_y`
* `frequency_body_gyroscope_std_z`                  
* `time_body_accelerometer_jerk_magnitude_mean`
* `time_body_accelerometer_jerk_magnitude_std`      
* `time_body_accelerometer_jerk_mean_x`
* `time_body_accelerometer_jerk_mean_y`             
* `time_body_accelerometer_jerk_mean_z`
* `time_body_accelerometer_jerk_std_x`              
* `time_body_accelerometer_jerk_std_y`
* `time_body_accelerometer_jerk_std_z`              
* `time_body_accelerometer_magnitude_mean`
* `time_body_accelerometer_magnitude_std`           
* `time_body_accelerometer_mean_x`
* `time_body_accelerometer_mean_y`                  
* `time_body_accelerometer_mean_z`
* `time_body_accelerometer_std_x`                   
* `time_body_accelerometer_std_y`
* `time_body_accelerometer_std_z`                   
* `time_body_gyroscope_jerk_magnitude_mean`
* `time_body_gyroscope_jerk_magnitude_std`          
* `time_body_gyroscope_jerk_mean_x`
* `time_body_gyroscope_jerk_mean_y`                 
* `time_body_gyroscope_jerk_mean_z`
* `time_body_gyroscope_jerk_std_x`                  
* `time_body_gyroscope_jerk_std_y`
* `time_body_gyroscope_jerk_std_z`                  
* `time_body_gyroscope_magnitude_mean`
* `time_body_gyroscope_magnitude_std`               
* `time_body_gyroscope_mean_x`
* `time_body_gyroscope_mean_y`                      
* `time_body_gyroscope_mean_z`
* `time_body_gyroscope_std_x`                       
* `time_body_gyroscope_std_y`
* `time_body_gyroscope_std_z`                       
* `time_gravity_accelerometer_magnitude_mean`
* `time_gravity_accelerometer_magnitude_std`        
* `time_gravity_accelerometer_mean_x`
* `time_gravity_accelerometer_mean_y`               
* `time_gravity_accelerometer_mean_z`
* `time_gravity_accelerometer_std_x`                
* `time_gravity_accelerometer_std_y`
* `time_gravity_accelerometer_std_z`                
               
This table is saved in a file called `merged.txt`

### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

The data in `mergedSet` is grouped by subject and activity and summarized. The resulting table `summarySet` has 68 columns and 180 rows (for 30 subjects and 6 activities). It is also saved in a file called `summary.txt`.

