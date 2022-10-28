Code Book 
=================

The dataset selected for this project comes from the Human Activity Recognition Using Smartphones Dataset, find out more information about the original dataset at the end of this file.

run_analysis.r
==============
The run_analysis.r performs the downloading, merging, selection, and tidying of the data.

0. load packages, in this case tidyverse

1. Downloading the data, we get a zip file.
	A directory for the data is created called data. The zip file is unzipped to data directory.
	There are many data sets but the ones we need for this project and loaded into Rstudio using read.table are:
		X_train.txt: training set with 7352 observations of 561 variables, all numeric from -1 to 1
		X_test.txt: test set with 2947 observations of 561 variables, all numeric from -1 to 1
		subject_train.txt: Subject identifier for the training set. Its range is from 1 to 30. 7352 observations
		subject_test.txt: Subject identifier for the test set. Its range is from 1 to 30. 2947 observations
		y_train.txt: Training set activity labels. 7352 observations 1 column with a number 1-6
		y_test.txt: Test set activity labels. 2947 observations 1 column with a number 1-6
		features.txt: Full list of the features in the data set. 561 feature names
		activity_labels.txt: Links the activity labels with their activity name. 6 rows 2 columns. 1-6 paired with its corresponding activity.

2. Merging all the data.
	Merge train and test set with rbind: 10299 observations 561 columns (numeric from -1 to 1)
	Merge the subject labels with rbind: 10299 observations 1 column (1-30)
	Merge the activity labels with rbind: 10299 observations 1 column (1-6)
	Left join activty names to the activity labels then select only the names: 10299 1 column (character, "walking", "running", etc)
	cbind the full data with the subject labels and activity names: 10299 observations 563 columns

3. Tidy the data.
	Change the column names in the data to the names provided in features.txt as well as the subject label column and the activity name column
	With grep() filter the names that contain mean() or std() and use that to select those columns from the data along with the subject and activity columns: 10299 observations 68 columns
	With gsub() change acronymns or short word forms to full length words for readability and remove any unnecessary symbols (tBodyAcc-mean()-X becomes TimeBodyAccelerationMeanX)
	Mutate the subject and activity columns to factors
	Summarize the data set by grouping by subject and activity and taking the mean of the rest of the 66 columns: 180 observations 68 columns (makes sense because 6 activities and 30 subjects 6x30 =180)
	output the tidy data to tidydata.txt

































ORIGINAL DATASET FEATURES
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
