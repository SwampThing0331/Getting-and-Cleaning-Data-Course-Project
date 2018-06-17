#getwd()
#setwd("~/datasciencecoursera/Getting_and_Cleaning_Data_Course_Project")

library(data.table)
library(tidyverse)

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./UCI HAR Dataset.zip")) {
      download.file(data_url, "UCI HAR Dataset.zip")
}
if(!file.exists("./UCI HAR Dataset")) {
      unzip("UCI HAR Dataset.zip")
}

features <- 
      read.table("./UCI HAR Dataset/features.txt") %>%
      select(V2) %>%
      as.list()

mstd_features <-
      grepl("mean|std", features$V2)

activities <-
      read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("class", "activity")) 

test_subjects <-
      read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

test_class <-
      read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "class")

test_data <-
      read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$V2) %>%
      cbind(test_subjects, test_class)

train_subjects <-
      read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

train_class <-
      read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "class")

train_data <-
      read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$V2) %>%
      cbind(train_subjects, train_class)

tt_data <- rbind(test_data, train_data)
tt_data <- tt_data[ , mstd_features]
tt_data <- left_join(tt_data, activities, by = "class") %>%
      as.data.table() %>%
      select("subject", "activity", everything(), -class)

tidy_data <- tt_data %>%
      group_by(subject, activity) %>%
      summarise_all(mean)

new_names <- gsub("\\.*", "", names(tidy_data))

colnames(tidy_data) <- new_names
      
if(!file.exists("./tidydata.txt")) {
      write.table(tidy_data, "tidydata.txt", row.names = FALSE, quote = FALSE)
}