# Getting and Cleaning Data Project
Course Project for the Getting and Cleaning Data Course on Coursera

The script makes use of the data.table library which would need to be loaded.

Using read.table, we read the variables names stored in the features file.
We create a vector of the indexes of the measurements on the mean and standard deviation by taking a look at the features file and selecting only the measurements ending in mean() or std().

Using read.table, we read the train data as well as the corresponding activity and subject data. We make use of the vector created above to extracting only the measurements on the mean and standard deviation for each measurement.

Similarly, we read the test data.

We use rbind to merge the training and test set.

We apply labels to the merged data set using the function colnames.

We assign descriptive activity names to the name the activities by taking a look at the activity_labes text file.

We use the order function to order the data set by activity then by subject.

We convert the data set into data table. We then use lapply to find the mean of each of the variables for each Activity and for each Subject.

