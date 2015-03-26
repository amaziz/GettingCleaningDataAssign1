library(dplyr)
# reading meta-data
feature.labels <- read.csv("activity_labels.txt", header = FALSE, sep="") # Read activity labels
feature.names <- read.csv("features.txt", header = FALSE, sep="") # Read feature names

# Read training data
train <- read.csv("train/X_train.txt", header = FALSE, sep="", col.names= feature.names[,2]) # read the x variables with their names
train <- train[,grep("mean()|std()", feature.names[,2])] # Filterout the unnecessary columns and keep only those for mean() and std()
ytrain <- read.csv("train/y_train.txt", header = FALSE, sep="", col.names="y") # read the y_train
subjecttrain <-read.csv("train/subject_train.txt", header = FALSE, sep="", col.names="subjectid") # read the subject ids for the training set
train<- cbind(train,ytrain, subjecttrain) # attach the y  and subjectid variables

# Read test data
test <- read.csv("test/X_test.txt", header = FALSE, sep="", col.names= feature.names[,2]) # read the x variables with their names
test <- test[,grep("mean()|std()", feature.names[,2])] # Filterout the unnecessary columns and keep only those for mean() and std()
ytest <- read.csv("test/y_test.txt", header = FALSE, sep="",  col.names="y") # read the y_train
subjecttest <-read.csv("test/subject_test.txt", header = FALSE, sep="", col.names="subjectid") # read the subject ids for the training set
test<- cbind(test, ytest, subjecttest) # attach the y  and subjectid variables

# bind data (training and test sets)
alldata<- rbind(train, test)

# data is merged with labels
mergeddata <- merge(feature.labels,alldata, by.y="y", by.x="V1")

# rename the V2 column to activity
mergeddata<- rename(mergeddata, activity = V2)

# remove the id column after merge
mergeddata<- select(mergeddata, -V1)

# Group by Subject Id and 
groupset <- group_by(mergeddata, subjectid, activity)
tidyset <- summarise_each(groupset, funs(mean))

write.table(tidyset, file="tidyset.txt", row.names=FALSE)
