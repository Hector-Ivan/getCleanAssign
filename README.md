getCleanAssign
==============

this repo is for the final project for JHOPS's 'Getting and Cleaning Data' and includes; run_analysis.R, codebook.md and README.md

The original data comes from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip with all the necessary files inside a zip file. This data was part of a study conducted at UCI about 'Human Activity Recognition Using Smartphones' and the info. can be accessed here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. What follows below is a detailed description of my script which has as its end goal, the production of a 'tidy' data set with means for each combination of variable, subject and activity. For this script, it is assumed that the zip file has been unzipped and the relevant files are in your working directory.
 
 <h2>Needed packages; 'reshape2' will be used in step 5</h2>

install.packages("reshape2")
library(reshape2)

 <h2>PRE-PROCESSING:  read in all files</h2>
  **read test files**

X_test<- read.csv("./test/X_test.txt",header=FALSE,sep="",comment.char="",colClasses="numeric")
y_test<- read.csv("./test/y_test.txt",header=FALSE,sep="")
subject_test<- read.csv("./test/subject_test.txt",header=FALSE,sep="")
  
 **read in train files**
X_train<- read.csv("./train/X_train.txt",header=FALSE,sep="",comment.char="",colClasses="numeric")
y_train<- read.csv("./train/y_train.txt",header=FALSE,sep="")
subject_train<-read.csv("./train/subject_train.txt",header=FALSE,sep="")

 <h2>PART 1: Merging training and test sets to make 1 big d.f</h2>
 **merge 3 test files together then 3 train files together, then**
 **test and train sets to each other**
          *change variable names for y_test and subject_test*
          *this facilitates the merging of the various sets*
names(y_test)<-"activity.labels"
names(subject_test)<- "subjectID"
          *merge X_test,y_test and subject_test into 1 data.frame*
testDat<- cbind(X_test,y_test,subject_test)
          *change var names for y_train and subject_train*
names(y_train)<-"activity.labels"
names(subject_train)<- "subjectID"
          *merge X_train, y_train and subject_train into 1 d.f*
trainDat<- cbind(X_train, y_train, subject_train)
 **lastly, merge testDat and trainDat to make one big d.f**
bigDat<- rbind(testDat,trainDat)

 <h2>PART 2: extract vars that have std() or mean()</h2>
         *read in features.txt and use as col names for X_test*
varNames<- read.csv("./features.txt",header=FALSE, sep="")
names(bigDat)<- c(as.character(varNames$V2),"activity.labels","subjectID")
        *extract relevant variables from bigDat by logical vector*
colNamesVec<-grepl("mean\\(\\)|std\\(\\)|activity|subject", names(bigDat))
bigDat<-bigDat[,colNamesVec]

 <h2>PART 3: change 'activity.labels' from number codes to words</h2>
     *using activity_labels.txt as source of activity names*
bigDat$activity.labels<-as.factor(bigDat$activity.labels)
levels(bigDat$activity.labels)<- list(WALKING="1",WALKING_UPSTAIRS="2",
                                      WALKING_DOWNSTAIRS="3", SITTING="4"
                                      , STANDING="5",LAYING="6")

 <h2>PART 4: manually label the var names descriptively</h2>
 * while bulky, I chose to manually create a vector because writing code to extract certain elements of the list of variable names would have been too complicated, this was simpler for me.*
names(bigDat)<- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z","tGravityAcc_std_X"
                  ,"tGravityAcc_std_Y","tGravityAcc_std_Z","tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z","tBodyGyro_mean_X","tBodyGyro_mean_Y" 
                  ,"tBodyGyro_mean_Z","tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z","tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z" 
                  ,"tBodyAccMag_mean","tBodyAccMag_std","tGravityAccMag_mean","tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std","tBodyGyroMag_mean","tBodyGyroMag_std","tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std"
                  ,"fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z","fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X"
                  ,"fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z","fBodyAccMag_mean","fBodyAccMag_std"
                  ,"fBodyAccJerkMag_mean","fBodyAccJerkMag_std","fBodyGyroMag_mean","fBodyGyroMag_std","fBodyGyroJerkMag_mean","fBodyGyroJerkMag_std","activity","subjectID" )


 <h2>PART 5: Creates a second, independent tidy data set</h2> 
  *with the average of each variable for each activity and each subject* 
  *here is where the 'reshape2' package comes in handy*
meltDat<-melt(bigDat, id=c("subjectID","activity")) 
castDat<- dcast(meltDat, subjectID+activity ~ variable,fun.aggregate=mean)