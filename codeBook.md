<h2>CODE BOOK</h2>
<h3>Original Data Set</h3>
<p>The variables represent measurements taken of subjects who were wearing accelerometer and gyroscope embedded smartphones. The subjects performed six activities:<br>
<ul>
	<li>WALKING</li>
	<li>WALKING_UPSTAIRS</li>
	<li>WALKING_DOWNSTAIRS</li>
	<li>SITTING</li>
	<li>STANDING</li>
	<li>LAYING</li>
</ul></p>
<p>
3-axial linear acceleration measures were taken using the accelerometer(total acceleration). The estimated body acceleration was also collected. Additionally, subjects were measured on 3-axial angular velocity using the gyroscope. Overall there were 561 features with time and frequency domain variables. There was also an 'activity labels' feature and a subject identification variable. Proportions were created by dividing quantities that had the same units, therefore the resulting variable values are unitless.<br>
</p>

<h3>Tidy Data Set</h3>
<p>The tidy data set generated with 'run_analysis.R' only includes 68 of the original 561 features and pertains only to features that had 'mean()' or 'std()' in their title(per assignment instructions). Some of the variable names were transformed. The original names, for example, were of the form 'tBodyAcc-mean()-X'. The dashes, '-', were replaced with underscores '_', and the parentheses '(' and ')' were removed, leaving the variable name in the form of 'tBodyAcc_mean_X'. 
</p>
<h3>Features Legend,/h3>
<p>
<dl>
	<dt>t</dt>
        	<dd>time domain</dd>
	<dt>f</dt>
		<dd>Frequency domain.</dd>
	<dt>mean</dt>
		<dd>Average for the preceding descriptors in the names.</dd>
	<dt>std</dt>
		<dd>standard deviation for the preceding descriptors in the names.</dd>
	<dt>X, Y, or Z</dt>
		<dd>Denotes 3-axial signals in the X, Y and Z directions.</dd>
	<dt>BodyAcc</dt>
		<dd>Measures acceleration signal for the body.</dd>
	<dt>GravityAcc</dt>
		<dd>Measures acceleration signals for gravity.</dd>
	<dt>BodyAccJerk</dt>
		<dd>Body linear acceleration jerk signals.</dd>
	<dt>BodyGyroJerk</dt>
		<dd>Angular velocity jerk signals.</dd>
	<dt>BodyAccMag</dt>
		<dd>Magnitude of body acceleration signals.</dd>
	<dt>GravityAccMag</dt>
		<dd>Magnitude of angular velocity signals.</dd>
	<dt>BodyAccJerkMag</dt>
		<dd>Magnitude of body acceleration jerk signals.</dd>
	<dt>BodyGyroMag</dt>
		<dd>Magnitude of body angular velocity signals.</dd>
	<dt>BodyGyroJerkMag</dt>
		<dd>Magnitude of angular velocity jerk signals.</dd>
	<dt>activity</dt>
		<dd>Class labels of the activity subjects engaged in.</dd>
	<dt>subjectID<dt>
		<dd>Unique subject identifier with values of 1-30.</dd>
</dl>
</p>

<h3>About the tidy data set</h3>
<p>The code in 'run_analysis.R' creates a 'wide' data set that has 180 observations of 68 variables. This is a good structure for viewing within the R console or perhaps an Excel document but for a 'txt' file, it is illegible. The tidy data set can therefore be converted to 'long' form which will make it readable if read into a 'txt' file. The code to do this is at the end of 'run_analysis.R' and is optional. This final code will produce a data set that is 11880 observations of 4 variables. The data was aggregated using the mean function. The code will write this last data set to a txt file called "tidyDat.txt" and will place it in one's working directory. The columns in 'tidyDat.txt' are the variables "subjectID", "activity", "variables" and "mean". The rows represent observations for each combination of 'subjectID', 'activity' and 'variables' which is the specific measurement taken(and are listed below in 'Features List'). The columns are not exactly aligned so it is essential to take precaution when reading.
</p>
<h3>Features List</h3>
<ul>
	<li>tBodyAcc_mean_X</li>
	<li>tBodyAcc_mean_Y</li>
        <li>tBodyAcc_mean_Z</li>
        <li>tBodyAcc_std_X</li>
        <li>tBodyAcc_std_Y</li>
	<li>tBodyAcc_std_Z</li>
	<li>tGravityAcc_mean_X</li>
        <li>tGravityAcc_mean_Y</li>
        <li>tGravityAcc_mean_Z</li>
        <li>tGravityAcc_std_X</li>
	<li>tGravityAcc_std_Y</li>
	<li>tGravityAcc_std_Z</li>
        <li>tBodyAccJerk_mean_X</li>
        <li>tBodyAccJerk_mean_Y</li>
        <li>tBodyAccJerk_mean_Z</li>
	<li>tBodyAccJerk_std_X</li>
	<li>tBodyAccJerk_std_Y</li>
        <li>tBodyAccJerk_std_Z</li>
        <li>tBodyGyro_mean_X</li>
        <li>tBodyGyro_mean_Y</li>
	<li>tBodyGyro_mean_Z</li>
	<li>tBodyGyro_std_X</li>
        <li>tBodyGyro_std_Y</li>
        <li>tBodyGyro_std_Z</li>
        <li>tBodyGyroJerk_mean_X</li>
	<li>tBodyGyroJerk_mean_Y</li>
	<li>tBodyGyroJerk_mean_Z</li>
        <li>tBodyGyroJerk_std_X</li>
        <li>tBodyGyroJerk_std_Y</li>
        <li>tBodyGyroJerk_std_Z</li>
	<li>tBodyAccMag_mean</li>
	<li>tBodyAccMag_std</li>
        <li>tGravityAccMag_mean</li>
        <li>tGravityAccMag_std</li>
        <li>tBodyAccJerkMag_mean</li>
	<li>tBodyAccJerkMag_std</li>
	<li>tBodyGyroMag_mean</li>
        <li>tBodyGyroMag_std</li>
        <li>tBodyGyroJerkMag_mean</li>
        <li>tBodyGyroJerkMag_std</li>
	<li>fBodyAcc_mean_X</li>
	<li>fBodyAcc_mean_Y</li>
        <li>fBodyAcc_mean_Z</li>
        <li>fBodyAcc_std_X</li>
        <li>fBodyAcc_std_Y</li>
	<li>fBodyAcc_std_Z</li>
	<li>fBodyAccJerk_mean_X</li>
        <li>fBodyAccJerk_mean_Y</li>
        <li>fBodyAccJerk_mean_Z</li>
        <li>fBodyAccJerk_std_X</li>
	<li>fBodyAccJerk_std_Y</li>
	<li>fBodyAccJerk_std_Z</li>
        <li>fBodyGyro_mean_X</li>
        <li>fBodyGyro_mean_Y</li>
        <li>fBodyGyro_mean_Z</li>
	<li>fBodyGyro_std_X</li>
	<li>fBodyGyro_std_Y</li>
        <li>fBodyGyro_std_Z</li>
        <li>fBodyAccMag_mean</li>
        <li>fBodyAccMag_std</li>
	<li>fBodyAccJerkMag_mean</li>
	<li>fBodyAccJerkMag_std</li>
        <li>fBodyGyroMag_mean</li>
        <li>fBodyGyroMag_std</li>
        <li>fBodyGyroJerkMag_mean</li>
	<li>fBodyGyroJerkMag_std</li>
	<li>activity</li>
        <li>subjectID</li>
</ul>