run_analysis.R functions

1. Merge files

  Function Name: mergeAndClean()

  Libraries used: dplyr
  
  Step 1: use the read.table function to place the raw data into the following data.frames:
  
    Test Data
      1. subject_test from "UCI_HAR_Dataset/test/subject_test.txt"
      2. readings_test from  "UCI_HAR_Dataset/test/X_test.txt"
      3. activity_test from "UCI_HAR_Dataset/test/y_test.txt"
    Train Data
      4. subject_train  from "UCI_HAR_Dataset/train/subject_train.txt"
      5. readings_train from "UCI_HAR_Dataset/train/X_train.txt"
      6. activity_train from "UCI_HAR_Dataset/train/y_train.txt"
  
  Step 2: use the rbind function to combine test and train data sets into subjects, readings,              and activity data.frames
  
  Step 3: rename columns (using the colnames function) in the readings data.frame with feature             namesread into a data.frame from "UCI_HAR_Dataset/features.txt"
  
 
  Step 4: use cbind function to add to the readings table the subject id column from the subjects           data.frame and feature id from the activity data.frame. Then renamed the columns                 (subjectId & activityId) using the colnames function.
  
  Step 5: select only the columns pertaining to mean and standard deviation (std), using the               select_if and grepl functions.
  
  Step 6: add descriptive activity names to replace the activityId's.  Read the activity labels            from "UCI_HAR_Dataset/activity_labels.txt" into activitylabels data.frame. Used                  colnames function to rename the columns (activityId & activityName).  Then used the              inner_join function to replace the activityId in the readings df with the descriptive            activityName from the activitylabels df
  
  Step 7: used the gsub function to strip the variable names of the punctuatin marks found in the           raw data set.
  
 
  
 
  
2.  Create independent tidy data set with the average of each variable for each activity and each     subject. 

    Function Name: tidyAverage()

    Libraries used: dplyr
    
    Step 1: call the mergeFiles function found in the previous section
    
    Step 2: use the group_by and summarise_all functions to get the data needed
    
    Step 3: use the write.table function to create teh text file ("fitbit_tidy_data.txt")







