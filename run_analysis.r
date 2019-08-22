#load library's -----
library(matrixStats) 
library(dplyr)

#dowload data 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_file <- paste(getwd(), "/data.zip")
download.file(url = url, destfile = dest_file)

#unzip data; functions returns path names of unzipped files
files <- unzip(dest_file)

#read test data
data_test <- do.call('cbind', lapply(files[5:13], function(x){data <- read.table(x, sep =""); result <- cbind(rowMeans(data),rowSds(as.matrix(data)))})) #read measurement data and calulate the mean and std
data_test <- cbind(data_test,read.table(files[16])) #Add activity
data_test <- cbind(data_test,read.table(files[14])) #Add subject

#read train data
data_train <- do.call('cbind', lapply(files[17:25], function(x){data <- read.table(x, sep =""); result <- cbind(rowMeans(data),rowSds(as.matrix(data)))})) #read measurement data and calulate the mean and std
data_train <- cbind(data_train,read.table(files[28])) #Add activity
data_train <- cbind(data_train,read.table(files[26])) #Add subject

#merge data-sets 
data_final <- rbind(data_test,data_train)

#changes colnames
colnames(data_final) <- c("BodyAcc-mean()-X", "BodyAcc-std()-X","BodyAcc-mean()-Y", "BodyAcc-std()-Y","BodyAcc-mean()-Z", "BodyAcc-std()-Z",
                         "BodyGyro-mean()-X", "BodyGyro-std()-X","BodyGyro-mean()-Y", "BodyGyro-std()-Y","BodyGyro-mean()-Z", "BodyGyro-std()-Z",
                         "TotalAcc-mean()-X", "TotalAcc-std()-X","TotalAcc-mean()-Y", "TotalAcc-std()-Y","TotalAcc-mean()-Z", "TotalAcc-std()-Z","Activity","Subject")

#Substitute activty codes by meaningfull values                      
activities_names <- read.table(files[1])
mapply(function(x,y) {data_final$Activity <<- gsub(x,y,data_final$Activity)}, activities_names$m, activities_names$V2)

#summarize dataset and export to .txt file
tidy_set <- group_by(data_final, Activity, Subject)
tidy_set <- summarize_all(tidy_set, funs(mean))
write.table(tidy_set,paste(getwd(),"/tidy_set.txt"),row.names=FALSE)
