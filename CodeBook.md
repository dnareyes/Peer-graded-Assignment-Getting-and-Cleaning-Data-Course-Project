# Code Book: Human Activity Recognition Using Smartphones

## Data Source
This dataset is derived from the UCI Human Activity Recognition Using Smartphones dataset. The original data was collected from 30 volunteers performing six activities while wearing a smartphone on their waist.

Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Processing Steps

1. **Data Collection**
   - Downloaded and extracted the original dataset
   - Loaded feature names and activity labels
   - Loaded training and test datasets

2. **Data Merging**
   - Combined training and test data into single datasets for subjects, activities, and features
   - Applied appropriate column names
   - Merged all data into one complete dataset

3. **Data Extraction**
   - Extracted only measurements related to mean and standard deviation

4. **Data Labeling**
   - Converted activity codes to descriptive activity names
   - Transformed variable names to be more descriptive:
     - Expanded prefix 't' to 'Time' and 'f' to 'Frequency'
     - Expanded 'Acc' to 'Accelerometer' and 'Gyro' to 'Gyroscope'
     - Expanded 'Mag' to 'Magnitude'
     - Fixed redundant 'BodyBody' to 'Body'
     - Formatted mean and standard deviation indicators

5. **Data Summarization**
   - Created a tidy dataset with the average of each variable for each activity and subject
   - Wrote the tidy dataset to a text file

## Variables

### Identifiers
- **Subject**: Subject identifier (1-30)
- **Activity**: Activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

### Measurements
The tidy dataset contains 66 measurement variables, which are averages of the mean and standard deviation measurements from the original dataset. These variables follow this naming pattern:

- **Time/Frequency**: Indicates time domain or frequency domain signals
- **Body/Gravity**: Source of acceleration signal
- **Accelerometer/Gyroscope**: Type of sensor
- **Jerk**: Linear acceleration and angular velocity
- **Magnitude**: Magnitude of signals 
- **Mean/StdDev**: Statistical measure
- **X/Y/Z**: 3-axial directions

