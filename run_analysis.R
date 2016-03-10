# 1.Merges the training and the test sets to create one data set.
# Read the data.

test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")
train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")

# Merge it together in the format- subjects, labels and rest.

gcdata <- rbind(cbind(test.subjects, test.labels, test.data),
                cbind(train.subjects, train.labels, train.data))

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# Read the features file.

features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# Only retain features of mean and standard deviation.

features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# Select means and standard deviations from gcdata
# Increment by 2 because gcdata has subjects and labels in the beginning

gcdata.mean.std <- gcdata[, c(1, 2, features.mean.std$V1+2)]

# 3.Uses descriptive activity names to name the activities in the data set.
# Read the activity_labels file.

labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)

# Replace labels in gcdata with label names.

gcdata.mean.std$label <- labels[gcdata.mean.std$label, 2]

# 4.Appropriately labels the data set with descriptive variable names.

# Make the list of existing column names and feature names.

good.colnames <- c("subject", "label", features.mean.std$V2)

# Prepare tidy object that list by removing every non-alphabetic character and converting to lowercase.

good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))

# Use the list as column names for data.

colnames(gcdata.mean.std) <- good.colnames

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
# Find the mean for each combination of subject and label

aggr.data <- aggregate(gcdata.mean.std[, 3:ncol(gcdata.mean.std)],
                       by=list(subject = gcdata.mean.std$subject, 
                               label = gcdata.mean.std$label),mean)


# Write the data for assignment upload
write.table(format(aggr.data, scientific=T), "tidy2.txt",
            row.names=F, col.names=F, quote=2)