#Decision tree


#train
startTime <- Sys.time()

glm_model <- ml_generalized_linear_regression(formula = formula, train_spar, type="classification")

endTime <- Sys.time()
trainTime <- endTime-startTime



# test 
start_Time <- Sys.time()

glm_pred <- ml_predict(glm_model, test_spar) 
end_Time <- Sys.time()

testTime <- end_Time-start_Time



#evaluation

predict.glm(glm_model, test_spar)

# printing results to file
setwd("C:/Users/ALI/Desktop/recommender_original_10-5-97/3-spark_cluster_sparklyr/")
sink(file = "out_spark/glm/glm_summarization11.txt", type = "output")
cat("decision glm summarization details:\n\n\n")

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







