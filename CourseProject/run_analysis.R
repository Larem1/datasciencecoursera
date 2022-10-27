#First set my working directory, i will comment out after
#setwd("C:/Users/all/Documents/Rprojs/Rproj's/Coursera/JohnHopsCourses/datasciencecoursera/CourseProject")

require(tidyverse)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "./projdata.zip") #downloading the zip to working directory

dir.create("./data") # create directory to store data

unzip("./projdata.zip", exdir = "./data") # unzip project data to data directory

training_set <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
test_set <- read.table("./data/UCI HAR Dataset/test/X_test.txt") # read in both data sets

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

activity_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

var_names <- read.table("./data/UCI HAR Dataset/features.txt")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


full_data <- rbind(test_set, training_set)

full_subjects <- rbind(subject_test, subject_train)

full_activity_nums <- rbind(activity_test, activity_train)
full_activity_names <- left_join(full_activity_nums, activity_labels, by = c("V1"="V1")) %>%
  select(V2)

full_data <- cbind(full_data, full_subjects, full_activity_names)

names(full_data) <- c(var_names$V2, "subject", "activity")

var_means_stds <- var_names$V2[grep("*mean\\(\\)*|*std\\(\\)*", var_names$V2)]

mean_std_data <- full_data %>%
  select(var_means_stds, subject, activity)

names(mean_std_data) <- names(mean_std_data)  %>%
  gsub("^t", "Time",.) %>%
  gsub("^f", "Frequency",.) %>%
  gsub("*Acc*", "Accuracy",.) %>%
  gsub("*Gyro*", "Gyroscope",.) %>%
  gsub("*Mag*", "Magnitude",.) %>%
  gsub("*mean\\(\\)\\-*", "Mean",.) %>%
  gsub("*std\\(\\)\\-*", "StandardDeviation",.) %>%
  gsub("-", "",.) %>%
  gsub("*BodyBody*", "Body",.)

mean_std_data <- mean_std_data %>%
  mutate(subject = as.factor(subject),
         activity = as.factor(activity))

last_mean_data <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarise_all(.funs = mean)

write.table(last_mean_data, "tidydata.txt")





