






#options(rsparkling.sparklingwater.version = "2.3.7")


#detach("package:rsparkling", unload = TRUE)
#if ("package:h2o" %in% search()) {
#  detach("package:h2o", unload = TRUE)
#}
#if (isNamespaceLoaded("h2o")) {
#  unloadNamespace("h2o")
#}
#remove.packages("h2o", lib = .libPaths()[1])

#install.packages("h2o",  type = "source",
#                 repos = "https://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/5/R"
#)
# **Restart your session**

#############################################################################################
#############################################################################################
###############################################################################################

#require(devtools)
#install_version("h2o", version = "3.18", repos = "https://cran.r-project.org")

library(tictoc)
library(data.table)
library(tidyr)
library(titanic)
library(ggplot2)
library(purrr)
library(sparklyr)
library(dplyr)
library(rsparkling)
library(h2o)
spark_disconnect_all()





#devtools::install_github("rstudio/sparklyr")
#install.packages("rsparkling")
#options(rsparkling.sparklingwater.version = "2.2.0")
#install.packages("h2o")
#spark_install(version = "2.2.0")


# data is being stored in data.table

library(tictoc)
library(data.table)
library(sparklyr)
library(dplyr)
library(tidyr)
library(titanic)
library(ggplot2)
library(purrr)

#library(liquidSVM)


conf <- spark_config()


options(rsparkling.sparklingwater.location="C:/sparkling-water-2.3.7/assembly/build/libs/sparkling-water-assembly_2.11-2.3.7-all.jar", 
        rsparkling.sparklingwater.version = "2.3.7")



sc <- spark_connect("spark://192.168.1.111:7077", version = "2.3.1", spark_home = "c:/spark-231")





#sc <- spark_connect(master = "local[4]", version = "2.2.0")


setwd("C:/Users/ALI/Desktop/recommender_original_10-5-97/03-spark_cluster_sparklyr/")

##########################################################
###########train##########################################

train0 <- read.csv("data/train.csv" )
test0 <- read.csv("data/test.csv" )

# copy to spark
train_spar <- copy_to(sc, train0, "train_spar", overwrite = TRUE )
tbl_vars(train_spar)


# copy to spark
test_spar <- copy_to(sc, test0, "test_spar", overwrite = TRUE)
tbl_vars(test_spar)

# transform our data set, and then partition into 'training', 'test'
#partitions <- movie_train_tbl %>%
# sdf_partition(training = 0.5, test = 0.5, seed = 888)


##########################################################
###########test##########################################





#features formula
formula = rating ~ age + gender + occupation + Action + Adventure + Animation + Children + Comedy + Crime + Documentary + Drama + Fantasy + FilmNoir + Horror + Musical + Mystery + Romance + SciFi + Thriller + War + Western
#8
#formula

