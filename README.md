# GettingCleaningDataAssign1

This file explains the code submitted in run_analysis.R beyond the comments already included there.

The script aims to summarize and clean data associated with device readinings from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ of a Samsung Galaxy S2 device. The experiment was conduced with 30 subjects.
For more details please refer to the original set here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The following operations are conducted:
1- The script loads the dplyr package that will be used later. Users should install it using the command install.packages("dplyr"), if missing.
2- The script reads the meta data and feature names. I choose to read it early-on to assign the feature names to data while reading it from files.
3- The script reads both training and test datasets
While reading each file, the feature names are added as column names.
Then, only features that have mean() or STD() in them are kept while the rest is removed.
Then, The y-variables (feature.labels) are read
Then, The subject-ids are read
Then, relevant columns are binded together for teh training and test sets
4- The trainind and test sets arebinded and the feature labels are merged
5- The columns are renamed and extra columns (id column from merge operation) is filtered-out
6- The dataframe is grouped by subject-id and activity and all other columns are summarized by their mean for the grouped columns
7- The data is written out to a text file in the same directory. The file name is "tidyset.txt"
