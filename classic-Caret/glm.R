
library("caret")
library(glmnet)
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
trueResults = as.factor(testData$rating)



#lmnet (method = 'glmnet')
#For classification and regression using packages glmnet and Matrix with tuning parameters:
# Mixing Percentage (alpha, numeric)
#Regularization Parameter (lambda, numeric)



train_start_time <- Sys.time()
model_glm <- train(formula, data=trainData, method = 'glmnet')
train_end_time <- Sys.time()





#Predict Function

test_start_time <- Sys.time()
predictions_glm <- predict(model_glm, newdata=testData)
test_end_time <- Sys.time()




# stores true results for the test data
trueResults = as.factor(testData$rating)


# summarization of the classification
summarization_glm = confusionMatrix(predictions_glm, trueResults)



# printing results to file
sink(file = "out/glm/summarization_glm.txt", type = "output")
cat("gbm summarization details:\n\n\n")


################################################
################################################
########Test result###############################

summarization_glm
####################
cat("Train time:\n")
train_end_time - train_start_time
######################

####################
cat("test time:\n")
test_end_time - test_start_time
######################

cat()

