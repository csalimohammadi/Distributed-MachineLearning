
# multi layer perceptron

#train


startTime <- Sys.time()

mlp_model <- ml_multilayer_perceptron_classifier( train_spar, formula = formula, layers = c(20, 10),
                                    max_iter = 100, step_size = 0.03, tol = 1e-06, block_size = 128,
                                    solver = "l-bfgs", seed = 1254, features_col = "features", 
                                    label_col = "label", prediction_col = "prediction",
                                    uid = random_string("multilayer_perceptron_classifier_"))

endTime <- Sys.time()
trainTime <- endTime-startTime





#test
start_Time <- Sys.time()
mlp_pred <- sdf_predict(mlp_model, test_spar)
end_Time <- Sys.time()
testTime <- end_Time-start_Time





accuracy_sammury <- ml_multiclass_classification_evaluator(mlp_pred, label_col = "label",
                                                           prediction_col = "prediction", metric_name = "accuracy",
                                                           uid = random_string("multiclass_classification_evaluator_"))

weightedPrecision_sammury <- ml_multiclass_classification_evaluator(mlp_pred, label_col = "label",
                                                                    prediction_col = "prediction", metric_name = "weightedPrecision",
                                                                    uid = random_string("multiclass_classification_evaluator_"))


weightedRecall_sammury <- ml_multiclass_classification_evaluator(mlp_pred, label_col = "label",
                                                                 prediction_col = "prediction", metric_name = "weightedRecall",
                                                                 uid = random_string("multiclass_classification_evaluator_"))

f1_sammury <- ml_multiclass_classification_evaluator(mlp_pred, label_col = "label",
                                                     prediction_col = "prediction", metric_name = "f1",
                                                     uid = random_string("multiclass_classification_evaluator_"))




# printing results to file
#setwd("C:/Users/ALI/Desktop/recommender_original_10-5-97/3-spark_cluster_sparklyr/")
sink(file = "out_spark/mlp/mlp_summarization11.txt", type = "output")
cat("MLP summarization details:\n\n\n")

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


ml_multiclass_classification_evaluator(mlp_pred)


#######################
#train time
######################
cat("\n\n\nTrain time:")
trainTime
cat("\n\n\ntest time:")
testTime

cat()


#spark_disconnect(sc)





