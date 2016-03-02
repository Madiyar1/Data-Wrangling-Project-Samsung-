---
title: "Data Wrangling Project"
author: "Madiyar Tuleuov"
date: "24 February 2016"
output: html_document
---
  ###Task 1: Merge two datasets (training and test) together. In our case the two datasets are identical, they have same variables.
  This can be done by using dplyr package and using functions:
  inner_join:
  bind_rows:
  make.names:
  merge :
  ###Step 1:
  Check in which working directory you are worikng in:
  getwd()
If needed setwd to the file where your data is located.
```{r}
getwd()
setwd("/Users/Madiyar/Desktop/UCI HAR Dataset-2")
library(dplyr)
```

Now lets get the data into R. We need to merge the train and test, so load both of them using read.table
###Below we are importing test and train data set:
```{r}
x_test <- read.table("~/Desktop/UCI HAR Dataset-2/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("~/Desktop/UCI HAR Dataset-2/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("~/Desktop/UCI HAR Dataset-2/test/subject_test.txt", quote="\"", comment.char="")
features <- read.table("~/Desktop/UCI HAR Dataset-2/features.txt", quote="\"", comment.char="")
x_train <- read.table("~/Desktop/UCI HAR Dataset-2/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/Desktop/UCI HAR Dataset-2/train/Y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/Desktop/UCI HAR Dataset-2/train/subject_train.txt", quote="\"", comment.char="")
activity_labels <- read.table("~/Desktop/UCI HAR Dataset-2/activity_labels.txt", quote="\"", comment.char="")
```
Now we need to check the matrix size and use the appropriate function to merge 2 data sets:
  ```{r}
dim(x_test)
dim(x_train)
dim(y_test)
dim(y_train)
dim(subject_test)
dim(subject_train)
```
Merging data sets:
  ```{r}
x <- bind_rows(x_test, x_train)
y <- bind_rows(y_test, y_train)
subject <- bind_rows(subject_test, subject_train)
samsung <- bind_cols(x, y, subject) 

```
###Task 2: Extracts columns containing mean and std.deviation for each measurement.
Variables needed are stored in features data set. However, the information is storesdin in x and y. First, we need to transform variable names and assign them to columns in x data set. Then make an extraction.
```{r}
colnames(x) <- c(make.names(features$V2, unique=TRUE, allow_ = TRUE))
mean_std <- x %>% 
  select(contains("mean"), contains("std"))

```
### Task 3: Creates variables called ActivityLabel and ActivityName that label all observations with the corresponding activity labels and names respectively.

```{r}
ActivityLabel <- c(1, 2, 3, 4, 5, 6)
ActivityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING",  "STANDING", "LAYING")
Activity = data.frame(ActivityLabel, ActivityNames)
```

### Task 4: From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Step1: Join the data sets subject, x, y and features
Step2: calclulate mean for each.
```{r}
samsung_tidy <- bind_cols(x, y, subject) %>% 
  left_join(activity_labels) %>% 
  summarise(mean=mean(samsung))
```
