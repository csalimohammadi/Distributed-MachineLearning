
#install.packages("doParallel")

library(caret)
library(doParallel)

registerDoParallel(cores = 2)







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


#write.csv(trainData,'train.csv')

#write.csv(testData,'test.csv')


# use all important data to predict the rating
formula = as.factor(rating) ~ age + gender + occupation + Action + Adventure + Animation + Children +   
  + Comedy + Crime + Documentary + Drama + Fantasy + FilmNoir + Horror +     
  + Musical + Mystery + Romance + SciFi + Thriller + War + Western

# build the neural net



# Train on entire training set.
# training <- data

numFolds <- trainControl(method = 'cv', number = 10, classProbs = TRUE, verboseIter = TRUE, summaryFunction = twoClassSummary, preProcOptions = list(thresh = 0.75, ICAcomp = 3))
train_start_time <- Sys.time()
fit2 <- train(formula, data = trainData, method = 'mlp')
train_end_time <- Sys.time()



# stores true results for the test data
trueResults = as.factor(testData$rating)

test_start_time <- Sys.time()
predicted <- predict(fit2, newdata=testData)
test_end_time <- Sys.time()
# summarization of the classification
summarization = confusionMatrix(predicted, trueResults)

# printing results to file
sink(file = "out/neuralNet/summarization_nlp.txt", type = "output")
cat("neural network summarization details:\n\n\n")
summarization
####################
cat("Train time:\n")
train_end_time - train_start_time
######################
cat("Test time:\n")
test_end_time - test_start_time

cat()



