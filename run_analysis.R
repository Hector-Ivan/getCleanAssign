install.packages("reshape2")
library(reshape2)

##### This script will have minimal comments. For a more detailed
### explanation, see README.md in this repo.

## PRE-PROCESSING
X_test<- read.csv("./test/X_test.txt",header=FALSE,sep="",comment.char="",colClasses="numeric")
y_test<- read.csv("./test/y_test.txt",header=FALSE,sep="")
subject_test<- read.csv("./test/subject_test.txt",header=FALSE,sep="")
  #read in train files
X_train<- read.csv("./train/X_train.txt",header=FALSE,sep="",comment.char="",colClasses="numeric")
y_train<- read.csv("./train/y_train.txt",header=FALSE,sep="")
subject_train<-read.csv("./train/subject_train.txt",header=FALSE,sep="")

#### PART 1: Merging training and test sets to make 1 big d.f
          #change variable names for y_test and subject_test
names(y_test)<-"activity.labels"
names(subject_test)<- "subjectID"
          #merge X_test,y_test and subject_test into 1 data.frame
testDat<- cbind(X_test,y_test,subject_test)
          #change var names for y_train and subject_train
names(y_train)<-"activity.labels"
names(subject_train)<- "subjectID"
          #merge X_train, y_train and subject_train into 1 d.f
trainDat<- cbind(X_train, y_train, subject_train)
## lastly, merge testDat and trainDat to make one big d.f
bigDat<- rbind(testDat,trainDat)

#### PART 2: extract vars that have std() or mean()
         #read in features.txt and use as col names for X_test
varNames<- read.csv("./features.txt",header=FALSE, sep="")
names(bigDat)<- c(as.character(varNames$V2),"activity.labels","subjectID")
        #extract relevant variables from bigDat by logical vector
colNamesVec<-grepl("mean\\(\\)|std\\(\\)|activity|subject", names(bigDat))
bigDat<-bigDat[,colNamesVec]

#### PART 3: change 'activity.labels' from number codes to words using
#activity_labels.txt
bigDat$activity.labels<-as.factor(bigDat$activity.labels)
levels(bigDat$activity.labels)<- list(WALKING="1",WALKING_UPSTAIRS="2",
                                      WALKING_DOWNSTAIRS="3", SITTING="4"
                                      , STANDING="5",LAYING="6")

#### PART 4: manually label the var names descriptively
names(bigDat)<- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z","tGravityAcc_std_X"
                  ,"tGravityAcc_std_Y","tGravityAcc_std_Z","tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z","tBodyGyro_mean_X","tBodyGyro_mean_Y" 
                  ,"tBodyGyro_mean_Z","tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z","tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z" 
                  ,"tBodyAccMag_mean","tBodyAccMag_std","tGravityAccMag_mean","tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std","tBodyGyroMag_mean","tBodyGyroMag_std","tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std"
                  ,"fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z","fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X"
                  ,"fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z","fBodyAccMag_mean","fBodyAccMag_std"
                  ,"fBodyAccJerkMag_mean","fBodyAccJerkMag_std","fBodyGyroMag_mean","fBodyGyroMag_std","fBodyGyroJerkMag_mean","fBodyGyroJerkMag_std","activity","subjectID" )


##PART 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#use reshape2 package with melting/casting.
meltDat<-melt(bigDat, id=c("subjectID","activity")) 
castDat<- dcast(meltDat, subjectID+activity ~ variable,fun.aggregate=mean)
head(castDat)

### OPTIONAL: convert from wide form to long form for the purpose 
# of writing out to a legible txt file.
#flipDat<- dcast(meltDat,subjectID+activity+variable~...,fun.aggregate=mean)
# write to a file (optional)
#write.table(flipDat, "tidyDat.txt",append = TRUE,quote=FALSE,sep=" ",dec=".",row.names=FALSE,col.names=c("subjectID","activity","variables","mean"))
