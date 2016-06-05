# Getting and Cleaning Data Course Project
# download_data.R
#
# Purpose:
# Download and unzip dataset for course project
#
# Usage:
# Set working directory to getting-cleaning-data directory
# source("download_data.R")
#
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("Dataset.zip")) {
	download.file(dataUrl, destfile = "Dataset.zip", method="curl")
}

if (!file.exists("UCI HAR Dataset")) {
	unzip(zipfile = "Dataset.zip")
}
