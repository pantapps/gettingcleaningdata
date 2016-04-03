Code Book
===================

Raw Data Set
-------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Transformations
-------------

To obtain a cleaned version of the data, the following transformations were performed:

 1. The training and data sets have been merged to create one data set.
 2. Only the measurements on the mean and standard deviation for each measurement have been extracted.
 3. Activities are listed with descriptive names.
 4. Variables have been labeled with descriptive names. 
 5. From the data set in step 4, a second independent tidy data set with the average of each variable for each activity and each subject was created.

Tidy Data Set
-------------

The tidy data set contains 180 observations with 68 variables divided in:

* Subject ID
*  Activity Name
*  Time and frequency domain signal variables (average of each variable for each activity and each subject )

The following list describes the variables in the tidy data set. The [Time/Frequency] prefix indicates that the variable is available for both Time and Frequency domain, with their respective preffix. The [Mean/STD] suffix indicates that the mean and the standard deviation for this variable are available, with their respective suffix. The [X,Y,Z] suffix indicates that the variable is available for the X,Y,Z axis, with their respective suffix:
                                                          
* [Time/Frequency]BodyAccelerometer[Mean/STD]-[X,Y,Z]
* TimeGravityAccelerometer[Mean/STD]-[X,Y,Z]
* [Time/Frequency]BodyAccelerometerJerk[Mean/STD]-[X,Y,Z]
* [Time/Frequency]BodyGyroscope[Mean/STD]-[X,Y,Z]
* TimeBodyGyroscopeJerk[Mean/STD]-[X,Y,Z]
* [Time/Frequency]BodyAccelerometerMagnitude[Mean/STD]  
* [Time/Frequency]GravityAccelerometerMagnitud[Mean/STD]    
* TimeBodyAccelerometerJerkMagnitude[Mean/STD]
* [Time/Frequency]eBodyGyroscopeMagnitudeMean[Mean/STD]
* [Time/Frequency]BodyGyroscopeJerkMagnitude[Mean/STD]