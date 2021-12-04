#install.packages("ROCR")
#install.packages("rpart")
#install.packages("rpart.plot")

# bar gozariye bastehaye morede estefade dar barname
# dar sarasare barname as tavabeye daroone bastehaye zir estefade mishavad.
library(ROCR)
library(rpart)
library(rpart.plot)



# moghayeseye har chahar ravesh ba ham.
#natayeje algoritmhaye bala ra daryaft karde va ba asase har algoritm yek khat dar nomoodar rasm mikonad
perf1 <- performance(predicted, "tpr", "fpr" )
perf2 <- performance(predicted, "tpr", "fpr")
perf3 <- performance(predicted, "tpr", "fpr")
perf4 <- performance(predicted, "tpr", "fpr")
plot(perf1, xlab="false positive rate", ylab="true positive rate",lwd=2,main="moghayeseye algoritmha",col="red",plotCI.lwd=2)
plot(perf2, avg="vertical", lwd=2, col="green",spread.estimate="stderror",plotCI.lwd=2,add=TRUE)
plot(perf3, avg="vertical", lwd=2, col="black",spread.estimate="stderror",plotCI.lwd=2,add=TRUE)
plot(perf4, avg="vertical", lwd=2, col="blue",spread.estimate="stderror",plotCI.lwd=2,add=TRUE)
legend(0.6,0.6,c('regression1','regression2','Tree','R-Forest'),col=c('red','green','black','blue'),lwd=2)

#########################################################