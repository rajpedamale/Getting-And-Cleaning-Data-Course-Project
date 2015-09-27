# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Downloads the dataset and unzips if it does not already exist in the working directory
2. Loads the activity and feature info
3. Defines a filter for mean and standard deviations to be extracted and sets up the names
4. Loads both the training and test datasets, as per above filter
5. Loads the activity and subject data for each dataset, and merges them as columns
   with the dataset
6. Merges the train and test datasets
7. Converts the `activity` and `subject` columns into factors
8. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
9. Prints the result to the file `tidy-data.txt`.
