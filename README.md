#Getting and Cleaning Data Course Project

The R script, run_analysis.R, takes the original data and organizes it for future analysis. The zip file can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Steps Performed:

1. Download and unzip data set
2. Extract measure column names from features.txt
3. Select required measure column indices (means and standard deviations)
4. Extract activity names and codes from activity_labels.txt
5. Read in subjects, activity codes (classes), and measurements for the train and test data
6. Combine all data for train and test sets individually
7. Combine train and test sets into one object
8. Subset combined data with columns from step 3
9. Retrieve activity names from step 4 by joining combined data to labels on activity code (class)
10. Group combined data by subject and activity to calculate averages
11. Replace the occurance of periods in column names
12. Write combined tidy data to tidydata.txt