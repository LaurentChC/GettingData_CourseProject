## CodeBook

The CodeBook provides the description of the the data that is contained in the 'tidyTable.txt' text file, as well as the description of how this table was constructed from available source data.

## Description of the data

The data table is about measurements that stem from a project 'Human Activity Recognition Using Smartphones Dataset' (see below).
- The data table contains 180 rows and 81 columns. Each row represents for one subject/activity combination (columns 1 and 2) the average values of 79 measured data. Since we have 30 individuals in the experiment, and each individual practised in the experiment the 6 defined activities, we thus arrive at the 180 columns.
- The 79 columns represent measurement aggregates, where the orginal variable name (that was maintained in the given table) contained either the 'mean' or the 'std' string.

## Data sources
Data were provided by the Coursera Datascience course, more precisely within the Getting and Cleaning Data Module, as a course project (course that started on 6 August 2015).
The **original data** were measured and collected in the project 'Human Activity Recognition Using Smartphones Dataset' (see reference 1. below).
Quotation from the 'README.txt' (see below):

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.* 

The files provided through this course, and used here are the following:

1. README.txt: general description of the experiment and the provided data files

2. features.info.txt: more detailed information on the measured data

3. features.txt: the list of the 561 measures or measure aggregates,

4. X_test.txt: a table with dimension (2947,561), where the 561 columns represent the different measurements or measurement aggregates

5. y_test.txt: a (2947,1) table that contains numbers between 1 and 6 and that encode the 6 different activities mentioned above. 

6. subject_test.txt: a (2947,1) table that contains numbers between 1 and 30 and encode the 30 individuals with whom the measurements were established.

7. X_train.txt: a table with dimension (7352,561), where the 561 columns represent the different measurements or measurement aggregates

8. y_train.txt: a (7352,1) table that contains numbers between 1 and 6 and that encode the 6 different activities mentioned above. 

9. subject_train.txt: a (7352,1) table that contains numbers between 1 and 30 and encode the 30 individuals with whom the measurements were established.

10. acivity_labels.txt: a correspondance table with dimension (6,2) that links the activity code to the activity label in plain text.

Note : we infer from the dimensions of the data tables that 
1. the features.txt data represent the descriptive variable names of the X_test.txt and X_train.txt measuremnt data

2. The y_test data represent the activities to link to the rows of the X_test data, ie row n of y_test indicates the activity for which the measuremnts in row n of table X_test were performed. The same holds for the y_train and X_train data.

3. The subject_test.txt data represent the subject to link to the rows of the X_test data, ie row n of y_test indicates the individual for which the measurements in row n of table X_test were performed. The same holds for the subject_train and X_train data.

## Construction of the tidyTable.txt data table
We constructed the table through the follwing steps:

1. For X_test and X_train separately, we define the descriptive variable names by setting the data of the features.txt file as names to the X_test and X_train tables.

2. For the y_test and y_train data separatley, we replace the code by the plain text name to obtain descriptive labels. We use the activity_lables.txt table for this transformation.

3. We respectively bind the subject and the (transformed) activty test resp. train columns to the left of the X_test resp. X_train tables.

4. We then aggregate these two tables by the rows, thus obtaining a new table with dimension (10299=2947+7352), 563=2+561)

5. We now select only the columns featuring in their varibale names either the 'mean' or the 'std' sequence, and thus select 79 columns.

6. For these measruements, we average over the subject x activity cross section, using the mean function. Since for each individual we have measures for each activity, we end up with 30 x 6 = 180 data rows.

## References
[1]. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Licence (reprinted from the README.txt)
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
