# Getting-and-Cleaning-Data-Course-Project
This repo is for the course project for getting and cleaning data course

This code basically performs the following sequence of steps.

Initialization step. Every Program starts with initialization in which we load the required libraries and clear the workspace.


Download data from net and unzip the files. Since the data source is on the internet, we need to download and unzip the files in working directory.

Load activity labels and features

After loading activity labels and features we extract only the data on mean and standard deviation

Load the datasets and assign them descriptive variable names called train, trainActivities, trainSubjects

Load the datasets and assign them descriptive variable names test, testActivities, testSubjects

Now merge train and test  datasets and add labels

From the allData data set, create a second, independent tidy data set with the average of each variable for each activity and each subject

Final step is to write output on the file "tidy.txt"


Signed_ Waqas Mansoor 
