# Getting and Cleaning Data

## Course Project

The purpose of this course project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This package contains the following files:

* **README.md** - introducing this project
* **CodeBook.md** - describing the variables, data and transformations
* **run_analysis.R** - script to prepare data for analysis
* **download_data.R** - helper script to download and unzip source data
* **merged.txt** - single data set produced by `run_analysis.R` (steps 1-4 below)
* **summary.txt** - independent tidy summary data set produced by `run_analysis.R` (step 5 below)

## run_analysis.R

Does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Usage

1. Download or clone this repo and set your working directory to its project directory
2. Run `source("download_data.R")` to download and unzip the data set
3. Run `source("run_analysis.R")` to generate two new files `merged.txt` and `summary.txt` in the working directory.

## Requirements

1. `run_analysis.R` expects the data set directory `UCI HAR Dataset` inside its working directory. The supplemental script `download_data.R` will create this directory with all required data file.
2. The `dplyr` package. If not already installed, please install with `install.packages("dplyr")`

