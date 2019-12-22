# Check&Load library Packages

check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("data.table")
check.packages(packages)
library("data.table")

#Get data from URL and unpack

path <- getwd()
if (!dir.exists("./UCI HAR Dataset/")){
  datalink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(datalink, file.path(path, "dataset.zip"))
  unzip(zipfile = "dataset.zip")}


#Read&Load data

#Train
X_train <- read.table(file.path(path, "UCI HAR Dataset/train/X_train.txt"))
Y_train <- read.table(file.path(path, "UCI HAR Dataset/train/y_train.txt"))
subj_train <- read.table(file.path(path, "UCI HAR Dataset/train/subject_train.txt"))


#Test
X_test <- read.table(file.path(path, "UCI HAR Dataset/test/X_test.txt"))
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subj_test <- read.table(file.path(path, "UCI HAR Dataset/test/subject_test.txt"))

#Merging Test and Train

data_X <- rbind(X_train, X_test)
data_Y <- rbind(Y_train, Y_test)
data_subj <- rbind(subj_train, subj_test)

dataFuse <- cbind(data_subj, data_Y, data_X)

#Features and selects mean and std deviation for each measurement

feats <- read.table(file.path(path, "UCI HAR Dataset/features.txt"))

featExtract <- feats[grepl("(mean()|std())\\(\\)", feats[, 2]), 2]
                     
dataFuse <- dataFuse[, c(1, 2, featExtract)]

#Activity labels

activLabels <- read.table(file.path(path, "UCI HAR Dataset/activity_labels.txt"))
dataFuse[, 2] <- activLabels [dataFuse[, 2], 2]

#Name variables and rename activity name with descriptive name

colnames(dataFuse)[1] <- "Subject"
colnames(dataFuse)[2] <- "Activity"
colnames(dataFuse) [3:ncol(dataFuse)] <- as.character(featExtract)
  
names(dataFuse) <- gsub("std()", "StdDev", names(dataFuse))
names(dataFuse) <- gsub("mean()", "Mean", names(dataFuse))
names(dataFuse) <- gsub("^t", "Time", names(dataFuse))
names(dataFuse) <- gsub("^f", "Frequency", names(dataFuse))
names(dataFuse) <- gsub("Acc", "Accelerometer", names(dataFuse))
names(dataFuse) <- gsub("Gyro", "Gyroscope", names(dataFuse))
names(dataFuse) <- gsub("Mag", "Magnitude", names(dataFuse))
names(dataFuse) <- gsub("BodyBody", "Body", names(dataFuse))
names(dataFuse) <- gsub("[()]", "", names(dataFuse))

#Creates a second data set with averange of each variable 
#for each activity and each subject

tidy_DT <- aggregate (. ~ Subject + Activity, data = dataFuse, FUN = mean )

#Outputs a .csv file with the averages
write.csv(tidy_DT, file = "./UCI HAR Dataset/tidy_set.csv")