###
setwd("C:\\D2WAP\\Training\\Analytics Accelerator\\Decision Tree")
library(rpart)
install.packages("rattle")
library(rattle)
##Read the data in the file
Titanic<-read.csv("train.csv")

Titanic <- Titanic[,-c(1,11,4,9)]
Titanic$Pclass <- as.factor(Titanic$Pclass)

fit<-rpart(Survived ~ Pclass+Sex+Age+SibSp+Parch+Fare+Embarked, data=Titanic, method="class")

###detailed results including splits
fancyRpartPlot(fit)
printcp(fit)

pfit <- prune(fit, cp = .010234)

fancyRpartPlot(pfit)