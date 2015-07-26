# Getting and Cleaning Data Course Project

*Author: Said HEZOUANI <shezouani@gmail.com>*

## Description
The run_analysis.R script merges the given data sets located in the Dataset folder, makes few column transformations and computes a tidy data set with the mean measurement values per subject and per activity.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This code book describes the variables, the data, and transformations or work that have been performed by the run_analysis.R script to clean up the data and to create the tidy data.

## Data
The R script run_analysis.R needs the following data sources to compute the requested data :

* Dataset/features.txt
* Dataset/activity_labels.txt
* Dataset/test/X_test.txt
* Dataset/test/y_test.txt
* Dataset/test/subject_test.txt
* Dataset/train/X_train.txt
* Dataset/train/y_train.txt
* Dataset/train/subject_train.txt

Refer to Dateset/README.txt for more details about the data sets

## Libraries
The R scripts depends on the following libraires :

* **dplyr** : The R script used the **dplyr** library which is loaded during the execution.


## Variables
During the execution, variables are created to handle intermediate and final results.

* **features** : loaded data table of features names. The columns are named **id** and **label**. Data loaded using `read.table()`

* **activities** : loaded data table of activities labels. The columns are named **id** and **label**. Data loaded using `read.table()`

* **XTestData** : loaded test data table of features measurments. The label column of features table is used to name the X data columns. Data loaded using `read.table()`

* **yTestData** : loaded test data table of measurement activity ids. The column is named **activity**. Data loaded using `read.table()`

* **subjTestData** : loaded test data table of measurement subject ids. The column is named **subject**. Data loaded using `read.table()`

* **XTrainData** : loaded training data table of features measurments. The label column of features table is used to name the X data columns. Data loaded using `read.table()`

* **yTrainData** : loaded training data table of measurement activity ids. The column is named **activity**. Data loaded using `read.table()`

* **subjTrainData** : loaded training data table of measurement subject ids. The column is named **subject**. Data loaded using `read.table()`

* **mergedTestData** : subjTestData, yTestData and XTestData columns are merged into a new table. Merge performed using `mergedTestData <- cbind(subjTestData,yTestData,XTestData)`

* **mergedTrainData** : subjTrainData, yTrainData and XTrainData columns are  merged nto a new table.  Merge performed using `mergedTrainData <- cbind(subjTrainData,yTrainData,XTrainData)`

* **mergedData** : test and training rows are merged (as requested in STEP 1). Merge performed using `mergedData <- rbind(mergedTestData,mergedTrainData)`
 
* **meanStdCols** : contains only the desired columns from the mergedData (as in STEP 2). The **dplyr** `select()` is used to perform column selection. In this step, all columns which label contains *mean* or *std* are selected.

* **tidyData** : summerized tidy data as requested in STEP 5. The **dplyr** `group_by()` and `summarise_each()` are used to compute the requested summary. This data table is saved to `tidy_data.txt` file using `write.table()` function

## Column transformations
Some columns are transformed during the R script execution.

* **mergedData$activity** : when loaded this column contains numerical ids of activities. Then, numerical values are replaced by matched labels from the activities list (as requested in STEP 3).

