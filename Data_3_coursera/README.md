#Getting and Cleaning Data - Course Project

Project related to the third module of the Data Science Specialization course.

In this project a tidy set will be produced starting from data collected in the "Human Activity Recognition Using Smartphones" study. 
Thanks to the use of inertial sensors integrated in smartphones, in this case the Samsung Galaxy S II, data from a group of 30 people 
aged between 19 and 48 years were collected when using the device. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist, so as to be able to produce by the signals of the 
gyroscope and accelerometer a set of data related to linear and angular accelerations of the 3 axes.
The data set can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The steps followed to get a tidy set are:

- Merges the training and the test sets to create one data set.

- Extracts only the measurements on the mean and standard deviation for each measurement.

- Uses descriptive activity names to name the activities in the data set

- Appropriately labels the data set with descriptive variable names.

- From the data set in step 4, creates a second, independent tidy data set with the 
  average of each variable for each activity and each subject.
