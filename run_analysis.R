mergeAndClean <- function(){
  
  library(dplyr)
  
  #### read test and train data into data frames
  
  subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
  readings_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
  activity_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")
  
  subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
  readings_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
  activity_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")
  
  #### combine test and train data sets
  
  subjects <- rbind(subject_test, subject_train)
  readings <- rbind(readings_test, readings_train)
  activity <- rbind(activity_test, activity_train)
  
  #### rename columns with feature names
  
  feature_names <- read.table("UCI_HAR_Dataset/features.txt")
  
  colnames(readings) = c(feature_names$V2)
  
  
  ##### add subject id column from subject table to readings table
  ##### add feature id column from activity table to readings table
  
  readings <- as.data.frame(cbind(subjects[1], activity[1], readings))
  
  colnames(readings)[1] = "subjectId"
  colnames(readings)[2] = "activityId"
  
  
  ##### select only the columns for mean and standard deviation
 
  
  readings <- readings %>% select_if(grepl("subject|activity|mean\\(\\)|std\\(\\)", names(.)))
 
  
  ##### add descriptive activity names to name the activities in the data set via activity_id
  
  activitylabels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
  
  colnames(activitylabels)[1] = "activityId"
  colnames(activitylabels)[2] = "activityName"
  
  
  final <- readings %>% inner_join(activitylabels, by="activityId")
  
  final <- select(final, activityId, activityName, everything())  %>% 
            select(-activityId)

  colnames(final) <- gsub("[[:punct:]]", "", colnames(final))
  colnames(final) <- gsub("mean", "Mean", colnames(final))
  colnames(final) <- gsub("std", "Std", colnames(final))
 
  
  #View(final)
  
  return(final)
  
}

tidyAverage <- function(){
  
  library(dplyr)
  
  tidy <- mergeFiles()
  
  tidyAvg <- tidy %>% 
    group_by(activityName, subjectId) %>%
    summarise_all("mean")
  
  write.table(tidyAvg, "fitbit_tidy_data.txt", row.names=FALSE)
  
  #View(tidyAvg)
  
}


