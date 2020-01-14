#packages
library("dplyr") #used for data transformation

# source the preparation (download + unzip) script 
source("prepare.R")

#read sets
## a function for safer reading for this type of data
readspec <- function(i) read.table(i,header = F, stringsAsFactors = F)

##read files common to both sets

activity_labels <- readspec('./UCI HAR Dataset/activity_labels.txt')
names(activity_labels) <- c("label", "activity")
features <- readspec('./UCI HAR Dataset/features.txt')

##read and tidy up each set

### input working subsirectories

dirs <- c("./UCI HAR Dataset/train/", "./UCI HAR Dataset/test/")

### obtain paths to individual files

trainfiles <- list.files(dirs[1])
testfiles <- list.files(dirs[2])
trainfilepath <- paste0(dirs[1], trainfiles)
testfilepath <- paste0(dirs[2], testfiles) 

### a function that reads each set by its path and tidies it up

readset <- function(setpath){
        
        # load individual files
        measurements <- readspec(setpath[3])
        activity <- readspec(setpath[4])
        subject <- readspec(setpath[2])
        
        # label with descriptive variable names
        names(measurements) <- features[[2]]
        names(subject) <- "Subject_ID"
        # Use descriptive activity names to name the activities in the data set
        names(activity) <- "label"
        activity <- full_join(activity, activity_labels, by = "label")
        
        return(cbind(subject, activity, measurements)[, -2])
}


### Read and tidy each set 

train <- readset(trainfilepath)
test <- readset(testfilepath)

# Merge the training and the test sets to create one data set

fullset <- bind_rows(train, test)

# Extract only the measurements on the mean and standard deviation for each measurement

fullset.means.stds <-
        fullset %>% dplyr::select_at(vars(
                "Subject_ID",
                "activity",
                contains("mean()"),
                contains("std()")
        ))


# from the extracted table, create a second, independent tidy data set with the average of each variable for each activity and each subject.

grp_summary <-
        fullset.means.stds %>% group_by(Subject_ID, activity) %>% summarise_all(mean)

#write to drive (optional)
# write.csv(fullset.means.stds,"full_means_stds.csv")
# write.csv(grp_summary,"Grouped_Summaries.csv")
