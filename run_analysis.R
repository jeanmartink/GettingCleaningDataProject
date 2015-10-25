# Assuming the Samsung data is in your working directory
# set your working directory to the folder containing the data

# load the necessary libraries
library(data.table)

# read the variables names stored in the features file
featuresAll <- read.table("./features.txt", header = FALSE)

# extract only the measurements on the mean 
# and standard deviation for each measurement
mean_std_only <- c(1:6,41:46,81:86,121:126,161:166,201:202,
                   214:215,227:228,240:241,253:254,266:271,
                   345:350,424:429,503:504,516:517,529:530,
                   542:543)
featuresNames <- featuresAll[mean_std_only,2]

# read the train data
# extract only the measurements on the mean 
# and standard deviation for each measurement
traindata <- read.table("./train/X_train.txt", header = FALSE)
traindata <- traindata[,mean_std_only]
train_activitydata <- read.table("./train/y_train.txt", header = FALSE)
train_subjectdata <- read.table("./train/subject_train.txt", header = FALSE)

# create the train set data to include subject and activity
trainset <- cbind(train_activitydata,train_subjectdata,traindata)

# read the test data
testdata <- read.table("./test/X_test.txt", header = FALSE)
testdata <- testdata[,mean_std_only]
test_activitydata <- read.table("./test/y_test.txt", header = FALSE)
test_subjectdata <- read.table("./test/subject_test.txt", header = FALSE)

# create the test set data to include subject and activity
testset <- cbind(test_activitydata,test_subjectdata,testdata)

# merge the training and the test sets to create one data set
mergedset <- rbind(trainset,testset)

# appropriately labels the data set with descriptive variable names
colnames(mergedset)[1:2] <- c("Activity","Subject")
colnames(mergedset)[3:68] <- as.character(featuresNames)

# use descriptive activity names to name the activities in the data set
mergedset[mergedset$Activity == 6,1] <- "LAYING"
mergedset[mergedset$Activity == 5,1] <- "STANDING"
mergedset[mergedset$Activity == 4,1] <- "SITTING"
mergedset[mergedset$Activity == 3,1] <- "WALKING_DOWNSTAIRS"
mergedset[mergedset$Activity == 2,1] <- "WALKING_UPSTAIRS"
mergedset[mergedset$Activity == 1,1] <- "WALKING"

# order the data set by activity and by subject
mergedset <- mergedset[order(mergedset$Activity,mergedset$Subject),]

# convert the data set into a data table
mergedsetDT <- data.table(mergedset)

# average of the mean variable for each activity and for each subject
avgByActBySubj <- mergedsetDT[,lapply(.SD,mean), .SDcols = 3:68, 
                               by = list(Activity,Subject)]
