
#Getting started with Naive Bayes

#Loading the library
#library(e1071)
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

# build the model vave bayes

#Fitting the Naive Bayes model
train_start_time <- Sys.time()
Naive_Bayes_Model=train(formula, data=trainData, method = 'naive_bayes')
train_end_time <- Sys.time()

Naive_Bayes_Model


#Prediction on the dataset
test_start_time <- Sys.time()
predicted=predict(Naive_Bayes_Model,testData)
test_end_time <- Sys.time()


#Confusion matrix to check accuracy
# stores true results for the test data
trueResults = as.factor(testData$rating)


# summarization of the classification
summarization = confusionMatrix(predicted, trueResults)


# printing results to file
sink(file = "out/naveBayes/summarization_naive_base.txt", type = "output")
cat("nave Bayes summarization details:\n\n\n")
summarization
####################
cat("Train time:\n")
train_end_time - train_start_time
######################
cat("Test time:\n")
test_end_time - test_start_time

cat()

