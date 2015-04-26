library(plyr)

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_data <- rbind(x_train, x_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_data <- rbind(y_train, y_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_data <- rbind(subject_train, subject_test)

features <- read.table("UCI HAR Dataset/features.txt")
req_features <- grep("-(mean|std)\\(\\)", features[, 2])

x_data <- x_data[, req_features]
names(x_data) <- features[req_features, 2]

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]

names(y_data) <- "activity"
names(subject_data) <- "subject"

complete_data <- cbind(x_data, y_data, subject_data)
averages <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages, "averages.txt", row.name=FALSE)