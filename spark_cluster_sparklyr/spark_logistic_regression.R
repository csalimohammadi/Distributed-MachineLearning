

# logistic regression layer perceptron

#train
startTime <- Sys.time()
fit <- ml_logistic_regression(train_spar, formula = formula)
endTime <- Sys.time()
trainTime <- endTime-startTime

# test 
start_Time <- Sys.time()

logist_pred <- ml_predict(fit, test_spar) 
end_Time <- Sys.time()

testTime <- end_Time-start_Time

#evaluation
accuracy_sammury <- ml_multiclass_classification_evaluator(logist_pred, label_col = "label",
                                                           prediction_col = "prediction", metric_name = "accuracy",
                                                           uid = random_string("multiclass_classification_evaluator_"))

weightedPrecision_sammury <- ml_multiclass_classification_evaluator(logist_pred, label_col = "label",
                                                                    prediction_col = "prediction", metric_name = "weightedPrecision",
                                                                    uid = random_string("multiclass_classification_evaluator_"))


weightedRecall_sammury <- ml_multiclass_classification_evaluator(logist_pred, label_col = "label",
                                                                 prediction_col = "prediction", metric_name = "weightedRecall",
                                                                 uid = random_string("multiclass_classification_evaluator_"))

f1_sammury <- ml_multiclass_classification_evaluator(logist_pred, label_col = "label",
                                                     prediction_col = "prediction", metric_name = "f1",
                                                     uid = random_string("multiclass_classification_evaluator_"))




# printing results to file
setwd("C:/Users/ALI/Desktop/recommender_original_10-5-97/3-spark_cluster_sparklyr/")
sink(file = "out_spark/logisticregression/logist_summarization11.txt", type = "output")
cat("logistic regression summarization details:\n\n\n")

#######################
#accuracy
##########################
cat("\n\n\nAccuracy:")
accuracy_sammury
#######################
#precision
##########################
cat("\n\n\nPrecision:")
weightedPrecision_sammury
#######################
#Recall
##########################
cat("\n\n\nRecall:")
weightedRecall_sammury
#######################
#f1
##########################
cat("\n\n\nF1:")
f1_sammury

#######################
#train time
######################
cat("\n\n\nTrain time:")
trainTime
cat("\n\n\ntest time:")
testTime

cat()


#spark_disconnect(sc)







