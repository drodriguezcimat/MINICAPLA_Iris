###################################
# CLASSIFICATION
###################################

library(class)
library(randomForest)

# Set random seed to make results reproducible:
set.seed(17)

# Calculate the size of each of the data sets:
data_set_size <- floor(PTRAIN*nrow(Xproy))

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(Xproy), size = data_set_size)

# Assign the data to the correct sets
training <- Xproy[indexes, ]
test     <- Xproy[-indexes,]

#GIT - EDITAR METODO DE CLASIFICACION ###################################
# Use KNN ##################
#prediction_training <- knn(training[,1:2],training[,1:2],cl=training$Species,k=PAR)
#prediction_test     <- knn(training[,1:2],test[,1:2],cl=training$Species,k=PAR)

# Use Random Forest ########
classifier = randomForest(Species ~ ., data=training, ntree=PAR, mtry=2, importance=TRUE)

# Predict classes for training and test sets
prediction_test      <- predict(classifier,test[,1:2])
prediction_training  <- predict(classifier,training[,1:2])

#########################################################################

#Calculate true positives
tp_train <- training$Species==prediction_training
tp_test  <- test$Species==prediction_test

#Calculate accuracy for training and test set
trainAcc <- round(100*sum(tp_train)/nrow(training),2)
testAcc  <- round(100*sum(tp_test)/nrow(test),2)


