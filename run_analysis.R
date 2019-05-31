library(plyr)
library(dplyr)
library(tidyr)
library(reshape2)

# Summary of what is done
# Data was separated into two groups: train and test. Each set of data consisted of 3 files: subject, activity and data.
# There was also a file [activity_labels.txt] with a description for each activityId 
# and another file [features.txt] with the names of al measurements included in the data file.

# First we join all three files for each group of data into a single dataset, each file had the same number of rows so it was
# logical for them to be joined by column.
# Load Activity labels and features into a separate dataset each.

# Merge Activity labels to each dataset (train and test), then we merge them by row to end up with a single dataset.
# The main data column contains one item per row matching the number of features in 'features.txt' so the data row 
# was split and each column was named as the corresponding feature in the file.

# Create a new dataset with only Subject, Activity, and columns with 'mean' or 'std' in their names. We did not include
# meanFreq or any column that did not have mean or std in their name.. eg. (some had mean in a parameter, we excluded those)

# The names of the columns where modified slightly to be more usefull, replaced 't' with time and 'f' with frequency. 
# 'Acc' was also replaced with Acceleration. The parenthesis were left 'as-is' so it becomes obvious the column is the result
# of some kind process or function.

# Finally aggregate the dataset by 'Subject' and 'Activity' as to have a wide tidy dataset 
# containing one row for each subject/activity with a mean of the aggregated values.

### SCRIPT STARTS HERE ###

# loading labels for activities, renaming the columns to something usefull and 
# making id column into a numeric type
act_labels <- read.csv("activity_labels.txt", header = FALSE)
act_labels <- rename(act_labels, Activity = V1)
act_labels <- separate(act_labels, Activity, c('ActivityId', 'Activity'), sep = ' ')
act_labels <- mutate(act_labels, ActivityId = as.integer(ActivityId))

# loading labels for features, renaming the columns to something usefull and 
# making id column into a numeric type
feature_labels <- read.table("features.txt", sep = " ", header = FALSE)
feature_labels <- rename(feature_labels, FeatureId = V1, Feature = V2)
# there are duplicate feature names so temporalily appended the id to the description
feature_labels <- mutate(feature_labels, Feature = paste(FeatureId, '_', as.character(Feature), sep = ''))
feature_labels <- select(feature_labels, Feature)


# loading test
# we add subject and descriptive data to have the complete test dataset
test_labels <- read.csv("test/y_test.txt", header = FALSE)
test_labels <- rename(test_labels, ActivityId = V1)

test_data <- read.csv("test/x_test.txt", header = FALSE)
test_data <- rename(test_data, Vector = V1)

test_subject <- read.csv("test/subject_test.txt", header = FALSE)
test_subject <- rename(test_subject, Subject = V1)

# merging columns from the Subject, Activity and Data into a single dataset
test_df = cbind(test_subject, test_labels, test_data)


# loading training data
# we add subject and descriptive data to have the complete training dataset
train_labels <- read.csv("train/y_train.txt", header = FALSE)
train_labels <- rename(train_labels, ActivityId = V1)

train_data <- read.csv("train/x_train.txt", header = FALSE)
train_data <- rename(train_data, Vector = V1)

train_subject <- read.csv("train/subject_train.txt", header = FALSE)
train_subject <- rename(train_subject, Subject = V1)

# merging columns from the Subject, Activity and Data into a single dataset
train_df <- cbind(train_subject, train_labels, train_data)

# Now we merge both datasets
df <- rbind(train_df, test_df)
df <- mutate(df, Vector = trimws(as.character(Vector)))

# Whe split the vector column by blank spaces to have one value per column
# and we name the new columns with the data from features.txt
df <- separate(df, Vector, into = feature_labels$Feature, sep = "[:blank:]+")

# Now we add activity descriptions
df <- merge(df, act_labels, by = "ActivityId")

# we make a new dtaset with only columns that contain mean
df_mean <- select(df, contains("mean"))
# remove those that have 'meanFreq'
df_mean <- select(df_mean, -contains("meanFreq"))
# remove those that have 'angle' because the take a mean as parameter but are not
# themselves named with mean
df_mean <- select(df_mean, -contains("angle("))

# A new dataset with only columns that contain 'std' on its name
df_std <- select(df, contains("std"))

# A new dataset with subject and Activity label
df <- select(df, Subject, ActivityId, Activity)

# Join previous datasets as to only have Subject, Activity, 'mean cols', 'std cols'
df <- cbind(df, df_mean, df_std) 

# Remove activityId
df <- select(df, -ActivityId)

# A bit of cleaning of the column names
# Replacing 't' with time and 'f' with frequency as to make it easier to understand
# Also replacing Acc with Acceleration
names(df) <- sub(".*_", "", names(df))
names(df) <- sub("^t","time", names(df))
names(df) <- sub("^f","fequency", names(df))
names(df) <- sub("Acc","Acceleration", names(df))

# Convert value columns to numeric
df[,3:68] = apply(df[,3:68], 2, function(x) as.numeric(as.character(x)))

# Final Dataset, using a wide dataset to show mean by activity and subject for every vaue
df <- aggregate(df[,3:68], by = list(Subject = df$Subject, Activity = df$Activity), FUN = mean)

# Output dataset
write.table(df, 'tidy_dataset.txt', row.names = FALSE)
