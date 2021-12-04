
#install.packages("e1071")
#install.packages("randomForest")
#install.packages("rpart.plot")
library(rpart.plot)
library("data.table")
#library("randomForest")
#library("e1071")
library("caret")


#loading data
#source('preprocessing.R')
# important features for the classification
importantFeatures = c('age', 'gender', 'occupation', as.character(data.genres[2:nrow(data.genres)]$nameGenre), 'rating')

#loading data which will be used for model generation
modelData = data.userMovieRating[, importantFeatures, with = F]

# splitting data into 80% train set and 20% test set
ind = sample(2, nrow(modelData), replace=TRUE, prob=c(0.8, 0.2))
trainData = modelData[ind==1, ]
testData = modelData[ind==2, ]

# use all important data to predict the rating
formula = as.factor(rating) ~ age + gender + occupation + Action + Adventure + Animation + Children +   
  + Comedy + Crime + Documentary + Drama + Fantasy + FilmNoir + Horror +     
  + Musical + Mystery + Romance + SciFi + Thriller + War + Western

# build the decision tree

train_start_time <- Sys.time()

trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3333)

dtree_fit <- train(formula, data = trainData, method = "rpart",
                   parms = list(split = "information"),
                   trControl=trctrl, tuneLength = 10)
train_end_time <- Sys.time()


dtree_fit



# stores true results for the test data
trueResults = as.factor(testData$rating)

# stores the predicted ratings by the previously created random forest rf
test_start_time <- Sys.time()
predicted=predict(dtree_fit, newdata = testData)
test_end_time <- Sys.time()

# summarization of the classification
summarization = confusionMatrix(predicted, trueResults)

# printing results to file
sink(file = "out/tree/summarization_tree.txt", type = "output")
cat("decision tree summarization details:\n\n\n")
summarization
####################
cat("Train time:\n")
train_end_time - train_start_time
######################
cat("Test time:\n")
test_end_time - test_start_time

cat()

