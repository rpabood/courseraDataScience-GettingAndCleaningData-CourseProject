
# Summary of what is done
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
