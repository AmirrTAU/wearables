#packages
library("dplyr")

# source the preparation (download + unzip) script - use only if you don't have the files already 

source("prepare.R")

#read

readspec <- function(i) read.table(i,header = F, stringsAsFactors = F)

activity_labels <- readspec('./UCI HAR Dataset/activity_labels.txt')
names(activity_labels)<-c("label","activity")
features <- readspec('./UCI HAR Dataset/features.txt')

dirs <- c("./UCI HAR Dataset/train/", "./UCI HAR Dataset/test/")

trainfiles <- list.files(dirs[1])
testfiles <- list.files(dirs[2])
trainfilepath <- paste0(dirs[1],trainfiles) 
testfilepath <- paste0(dirs[2],testfiles) 


readset <- function(setpath){

        measurements <- readspec(setpath[3])
        activity <- readspec(setpath[4])
        subject <- readspec(setpath[2])
        
        # label the data set with descriptive variable names
        names(measurements) <- features[[2]] 
        names(subject) <- "Subject_ID"
        # Use descriptive activity names to name the activities in the data set
        names(activity) <- "label"
        activity <- full_join(activity,activity_labels, by="label") 

        return(cbind(subject,activity,measurements)[,-2])
}


# Merge the training and the test sets to create one data set

train <- readset(trainfilepath)
test <- readset(testfilepath)
fullset <- bind_rows(train,test)

# Extract only the measurements on the mean and standard deviation for each measurement

extracted <-
        fullset %>% dplyr::select_at(vars("Subject_ID","activity", contains("mean()"),contains("std()")))


#create a second, independent tidy data set with the average of each variable for each activity and each subject.

grp_summary <- extracted %>% group_by(Subject_ID,activity) %>% summarise_all(mean)

write.csv(grp_summary,"Grouped_Summaries.csv")


# X_train <- read.table('./UCI HAR Dataset/train/X_train.txt', header = F, stringsAsFactors = F)
# y_train <- read.table('./UCI HAR Dataset/train/y_train.txt', header = F, stringsAsFactors = F)
# 
# subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = F, stringsAsFactors = F)
# 
# activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = F, stringsAsFactors = F)
# 
# features <- read.table('./UCI HAR Dataset/features.txt', header = F, stringsAsFactors = F)
# 
# names(X_train) <- features[[2]]
# names(y_train) <- "label"
# names(activity_labels)<-c("label","activity")
# y_train <- full_join(y_train,activity_labels, by="label")
# 
# return(cbind(y_train,X_train))
# }
# 
# 
# t
# readset <- function(i) read.table(i, header = F, stringsAsFactors = F)
# trainset <- lapply(trainfilepath,read.table)




# 