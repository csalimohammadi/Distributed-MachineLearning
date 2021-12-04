
#install.packages("e1071")
#install.packages("randomForest")
library("data.table")
#library("randomForest")
#library("e1071")
library("caret")

# loading data
#source('preprocessing.R')
# important features for the classification
importantFeatures = c('age', 'gender', 'occupation', as.character(data.genres[2:nrow(data.genres)]$nameGenre), 'rating')

# loading data which will be used for model generation
modelData = data.userMovieRating[, importantFeatures, with = F]

# splitting data into 80% train set and 20% test set
ind = sample(2, nrow(modelData), replace=TRUE, prob=c(0.8, 0.2))
trainData = modelData[ind==1, ]
testData = modelData[ind==2, ]

# use all important data to predict the rating
formula = as.factor(rating) ~ age + gender + occupation + Action + Adventure + Animation + Children +   
  + Comedy + Crime + Documentary + Drama + Fantasy + FilmNoir + Horror +     
  + Musical + Mystery + Romance + SciFi + Thriller + War + Western

# build the random forest

train_start_time <- Sys.time()
rf = train(formula, data = trainData, method = "ranger")
train_end_time <- Sys.time()

# stores true results for the test data
trueResults = as.factor(testData$rating)

# stores the predicted ratings by the previously created random forest rf
test_start_time <- Sys.time()
predicted = predict(rf, newdata = testData) 
test_end_time <- Sys.time()

# summarization of the classification
summarization = confusionMatrix(predicted, trueResults)

# printing results to file
sink(file = "out/randomForest/summarization_ranger.txt", type = "output")
cat("Random Forest summarization details:\n\n\n")
summarization
############################
####################
cat("Train time:\n")
train_end_time - train_start_time
######################
cat("Test time:\n")
test_end_time - test_start_time

cat()

