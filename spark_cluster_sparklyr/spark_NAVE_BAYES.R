


#train
startTime <- Sys.time()

bayes_model <- ml_naive_bayes(train_spar, formula=formula)

endTime <- Sys.time()
trainTime <- endTime-startTime



# test 
start_Time <- Sys.time()

bayes_pred <- ml_predict(bayes_model, test_spar) 
end_Time <- Sys.time()

testTime <- end_Time-start_Time

accuracy_sammury <- ml_multiclass_classification_evaluator(bayes_pred, label_col = "label",
                                  prediction_col = "prediction", metric_name = "accuracy",
                                  uid = random_string("multiclass_classification_evaluator_"))

weightedPrecision_sammury <- ml_multiclass_classification_evaluator(bayes_pred, label_col = "label",
                                                           prediction_col = "prediction", metric_name = "weightedPrecision",
                                                           uid = random_string("multiclass_classification_evaluator_"))


weightedRecall_sammury <- ml_multiclass_classification_evaluator(bayes_pred, label_col = "label",
                                                           prediction_col = "prediction", metric_name = "weightedRecall",
                                                           uid = random_string("multiclass_classification_evaluator_"))

f1_sammury <- ml_multiclass_classification_evaluator(bayes_pred, label_col = "label",
                                                           prediction_col = "prediction", metric_name = "f1",
                                                           uid = random_string("multiclass_classification_evaluator_"))




# printing results to file
#setwd("C:/Users/ALI/Desktop/recommender_original_10-5-97/3-spark_cluster_sparklyr/")
sink(file = "out_spark/bayes/summarization_nave.txt", type = "output")
cat("nave bayes summarization details:\n\n\n")

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


