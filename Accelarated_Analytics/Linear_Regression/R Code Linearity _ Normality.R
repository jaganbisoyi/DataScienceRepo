#Reading the dataset
a <- read.csv("C:\\D2WAP\\Training\\Analytics Accelerator\\Session 3 - Regression\\cars.csv")

#doing a basic plot
plot(a$Horsepower, a$Actual.MPG)

#Creating the model
model1 <- lm(Actual.MPG~Horsepower, data = a)

#Checking the results
summary(model1)

#Checking the normality
qqPlot(model1$residuals)
boxplot(model1$residuals)

#Creating a new dataset
b <- a

#Ensuring Linearity
b$Horsepower <- log(a$Horsepower)
plot(b$Horsepower, b$Actual.MPG)

#Reexecuting the model
model2 <- lm(Actual.MPG~Horsepower, data = b)

#Checking the results
summary(model2)

#Checking normality
qqPlot(model2$residuals)
boxplot(model2$residuals)

#further improving the results
b$Actual.MPG <- log(a$Actual.MPG)

#Checking the linearity assumptions
plot(b$Horsepower, b$Actual.MPG)

#Reexecuting the model
model3 <- lm(Actual.MPG~Horsepower, data = b)

#Checking the results
summary(model3)

#Checking the normality assumptions
qqPlot(model3$residuals)
boxplot(model3$residuals)