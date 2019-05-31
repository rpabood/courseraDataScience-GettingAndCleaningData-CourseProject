
# title: Getting and Cleaning Data Course Project

## Project Description
Obtain a tidy dataset from data provided. It should include measurements with STD or MEAN, 
and provide an average for each activity and each subject.

### Study design and data processing

According to the Readme.txt of the data provided:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Creating the tidy datafile

#### Guide to create the tidy data file
Data was separated into two groups: train and test. Each set of data consisted of 3 files: subject, activity and data.
There was also a file [activity_labels.txt] with a description for each activityId 
and another file [features.txt] with the names of al measurements included in the data file.

First we join all three files for each group of data into a single dataset, each file had the same number of rows so it was
logical for them to be joined by column.
Load Activity labels and features into a separate dataset each.

Merge Activity labels to each dataset (train and test), then we merge them by row to end up with a single dataset.
The main data column contains one item per row matching the number of features in 'features.txt' so the data row 
was split and each column was named as the corresponding feature in the file.

Create a new dataset with only Subject, Activity, and columns with 'mean' or 'std' in their names. We did not include
meanFreq or any column that did not have mean or std in their name.. eg. (some had mean in a parameter, we excluded those)

The names of the columns where modified slightly to be more usefull, replaced 't' with time and 'f' with frequency. 
'Acc' was also replaced with Acceleration. The parenthesis were left 'as-is' so it becomes obvious the column is the result
of some kind process or function.

Finally aggregate the dataset by 'Subject' and 'Activity' as to have a wide tidy dataset 
containing one row for each subject/activity with a mean of the aggregated values.

### Description of the variables in the dataset file

Data report overview

Feature                 | Result
------------------------|---------
Number of observations  |  180
Number of variables     |   68


# Codebook summary table

-------------------------------------------------------------------------------------------
Label   Variable                                           Class         # unique  Missing    
                                                                           values                        
------- -------------------------------------------------- ----------- ---------- --------- 
        **[Subject]**                                      integer             30  0.00 %                

        **[Activity]**                                     character            6  0.00 %                

        **[timeBodyAcceleration-mean()-X]**                numeric            180  0.00 %                

        **[timeBodyAcceleration-mean()-Y]**                numeric            180  0.00 %                

        **[timeBodyAcceleration-mean()-Z]**                numeric            180  0.00 %                

        **[timeGravityAcceleration-mean()-X]**             numeric            180  0.00 %                

        **[timeGravityAcceleration-mean()-Y]**             numeric            180  0.00 %                

        **[timeGravityAcceleration-mean()-Z]**             numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-mean()-X]**            numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-mean()-Y]**            numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-mean()-Z]**            numeric            180  0.00 %                

        **[timeBodyGyro-mean()-X]**                        numeric            180  0.00 %                

        **[timeBodyGyro-mean()-Y]**                        numeric            180  0.00 %                

        **[timeBodyGyro-mean()-Z]**                        numeric            180  0.00 %                

        **[timeBodyGyroJerk-mean()-X]**                    numeric            180  0.00 %                

        **[timeBodyGyroJerk-mean()-Y]**                    numeric            180  0.00 %                

        **[timeBodyGyroJerk-mean()-Z]**                    numeric            180  0.00 %                

        **[timeBodyAccelerationMag-mean()]**               numeric            180  0.00 %                

        **[timeGravityAccelerationMag-mean()]**            numeric            180  0.00 %                

        **[timeBodyAccelerationJerkMag-mean()]**           numeric            180  0.00 %                

        **[timeBodyGyroMag-mean()]**                       numeric            180  0.00 %                

        **[timeBodyGyroJerkMag-mean()]**                   numeric            180  0.00 %                

        **[fequencyBodyAcceleration-mean()-X]**            numeric            180  0.00 %                

        **[fequencyBodyAcceleration-mean()-Y]**            numeric            180  0.00 %                

        **[fequencyBodyAcceleration-mean()-Z]**            numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-mean()-X]**        numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-mean()-Y]**        numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-mean()-Z]**        numeric            180  0.00 %                

        **[fequencyBodyGyro-mean()-X]**                    numeric            180  0.00 %                

        **[fequencyBodyGyro-mean()-Y]**                    numeric            180  0.00 %                

        **[fequencyBodyGyro-mean()-Z]**                    numeric            180  0.00 %                

        **[fequencyBodyAccelerationMag-mean()]**           numeric            180  0.00 %                

        **[fequencyBodyBodyAccelerationJerkMag-mean()]**   numeric            180  0.00 %                

        **[fequencyBodyBodyGyroMag-mean()]**               numeric            180  0.00 %                

        **[fequencyBodyBodyGyroJerkMag-mean()]**           numeric            180  0.00 %                

        **[timeBodyAcceleration-std()-X]**                 numeric            180  0.00 %                

        **[timeBodyAcceleration-std()-Y]**                 numeric            180  0.00 %                

        **[timeBodyAcceleration-std()-Z]**                 numeric            180  0.00 %                

        **[timeGravityAcceleration-std()-X]**              numeric            180  0.00 %                

        **[timeGravityAcceleration-std()-Y]**              numeric            180  0.00 %                

        **[timeGravityAcceleration-std()-Z]**              numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-std()-X]**             numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-std()-Y]**             numeric            180  0.00 %                

        **[timeBodyAccelerationJerk-std()-Z]**             numeric            180  0.00 %                

        **[timeBodyGyro-std()-X]**                         numeric            180  0.00 %                

        **[timeBodyGyro-std()-Y]**                         numeric            180  0.00 %                

        **[timeBodyGyro-std()-Z]**                         numeric            180  0.00 %                

        **[timeBodyGyroJerk-std()-X]**                     numeric            180  0.00 %                

        **[timeBodyGyroJerk-std()-Y]**                     numeric            180  0.00 %                

        **[timeBodyGyroJerk-std()-Z]**                     numeric            180  0.00 %                

        **[timeBodyAccelerationMag-std()]**                numeric            180  0.00 %                

        **[timeGravityAccelerationMag-std()]**             numeric            180  0.00 %                

        **[timeBodyAccelerationJerkMag-std()]**            numeric            180  0.00 %                

        **[timeBodyGyroMag-std()]**                        numeric            180  0.00 %                

        **[timeBodyGyroJerkMag-std()]**                    numeric            180  0.00 %                

        **[fequencyBodyAcceleration-std()-X]**             numeric            180  0.00 %                

        **[fequencyBodyAcceleration-std()-Y]**             numeric            180  0.00 %                

        **[fequencyBodyAcceleration-std()-Z]**             numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-std()-X]**         numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-std()-Y]**         numeric            180  0.00 %                

        **[fequencyBodyAccelerationJerk-std()-Z]**         numeric            180  0.00 %                

        **[fequencyBodyGyro-std()-X]**                     numeric            180  0.00 %                

        **[fequencyBodyGyro-std()-Y]**                     numeric            180  0.00 %                

        **[fequencyBodyGyro-std()-Z]**                     numeric            180  0.00 %                

        **[fequencyBodyAccelerationMag-std()]**            numeric            180  0.00 %                

        **[fequencyBodyBodyAccelerationJerkMag-std()]**    numeric            180  0.00 %                

        **[fequencyBodyBodyGyroMag-std()]**                numeric            180  0.00 %                

        **[fequencyBodyBodyGyroJerkMag-std()]**            numeric            180  0.00 %                
-------------------------------------------------------------------------------------------
