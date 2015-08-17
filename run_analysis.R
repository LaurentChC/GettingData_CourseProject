## The purpose of this R script is to collect, clean and transform data under the "tidy data" 
## principles. The data were provided by the Coursera Datascience "GettingData" course
## that started on 6 August 2015. More precisely, the data were provided 
## within the course project. 

## According to the licence agreement for the use of the data (cf. README.txt file 
## provided with the data), I refer to the following publication [1] 
## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support
## Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-
## Gasteiz, Spain. Dec 2012


## We suppose that all provided data files are in the working directory and
## can thus be directly addressed by the read.table function without specifying 
## any directory


## We will provide for the use of the dplyr package for some table manipulations
library(dplyr)

## We read in the .txt files. As data are separated by the tab, we read them in with the read.table 
## function that has this separator as default value

features <- read.table("features.txt") # we check dimensions : dim(features) (561,2)

test_X <- read.table("X_test.txt")
test_y <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
# We check dimensions: dim(test_X) (2947,561), dim(test_y) (2947,1)
# dim(test_subject_test) (2947,1)

train_X <- read.table("X_train.txt")
train_y <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
# We check dimensions: dim(train_X) (7352,561), dim(train_y) (7352,1) 
# dim(train_subject_train) (7352,1)

## We infer, that the features file represents the column names of the measurement tables
## We set the variable names 

names(test_X) <- features$V2
names(test_y) <- "activity"
names(subject_test) <- "subject"
names(train_X) <- features$V2
names(train_y) <- "activity"
names(subject_train) <- "subject"

## We now replace the activity code of the test_y (train_y) files by the 
## activity labels

# We load the activity_labels.txt file as correspondance table
activity_correspondance <- read.table("activity_labels.txt")

## Replacement of the activity code with the activity label for the test_y table

# We link the activity code to the activity label through a merge 
# Before, we add to test_y a colmun with the rownames as ordering column.
# The merge function risks changing the order of the rows in test_y 
# We therefore need to convert to numerical or integer value
test_y_expand <- mutate(test_y, rank = as.integer(rownames(test_y)))
act_label_test_help <- merge(test_y_expand, activity_correspondance, by.x = "activity", by.y = "V1", all = TRUE)
## Now, by ordering on the rank column, we get the right order
act_label_test_ord <- arrange(act_label_test_help, rank)
## We now extract only the (third) column which contains the activity label
act_label_test <- as.data.frame(act_label_test_ord[,3]) 
# Attention: act_label_test_ord[,3] is a factor. Fur usage further down, need to transform
# into dataframe.
names(act_label_test) <- "activity"

## Replacement of the activity code with the activity label for the train_y table

# We do the same as above, now with the train_y table. Replace 'test' in the script above by 'train'
train_y_expand <- mutate(train_y, rank = as.integer(rownames(train_y)))
act_label_train_help <- merge(train_y_expand, activity_correspondance, by.x = "activity", by.y = "V1", all = TRUE)
act_label_train_ord <- arrange(act_label_train_help, rank)
act_label_train <- as.data.frame(act_label_train_ord[,3])
names(act_label_train) <- "activity"

## Binding the subject and activity columns on the left to the measurement tables

test_data <- cbind(subject_test, act_label_test, test_X, deparse.level = 1)
train_data <- cbind(subject_train, act_label_train, train_X, deparse.level = 1)

## We now put the test_data and train_data tables together by a row bind
all_data <- rbind(test_data, train_data, deparse.level = 1)
# dimension check: dim(all_data) (10299,563)

## We now select the columns that contain the mean and standard deviation data.
## For that purpose, we must identify the columns where the column name includes
## 'mean' or 'std'. For further analysis (aggregation), we must also keep the
## 'subject' and 'activity' columns.

reducedTable <- all_data[,grepl("subject|activity|std|mean", names(all_data))]
# dimension check: dim(reducedTable) (10299,81)

## We then aggregate by grouping along the 2 columns, aggregation function 'mean'
## Our interpretation here is that the averaging is performed over the
## subject x activity intersections

# Grouping implies that the 2 relevant columns are coerced as factors
reducedTable$subject <- as.factor(reducedTable$subject)
reducedTable$activity <- as.factor(reducedTable$activity)

# Putting the 2 factors together, we contruct the grouped dataframe
by_subjectactivity <- group_by(reducedTable, subject, activity)

# Using the summarise_each function of the dplyr package with relevant syntax,
# and making use of the pipeline operator %>%, we calculate the mean over the groups for
# each measurement (column)
# Note that grouping columns are by default excluded from the summarise statistics 
tidyTable <- by_subjectactivity %>% summarise_each(funs(mean))

## We write the obtained dataframe into a .txt file
write.table(tidyTable,"tidyTable.txt",row.names = FALSE)