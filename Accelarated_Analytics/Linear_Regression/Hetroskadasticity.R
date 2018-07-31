#Read the file
a <- read.csv("C:\\D2WAP\\Training\\Analytics Accelerator\\Session 3 - Regression\\cars.csv")

#pick required columns
a <- a[,2:8]

#check basic plots
plot(a$Cylinders, a$Actual.MPG)
plot(a$Engine.Disp, a$Actual.MPG)
plot(a$Horsepower, a$Actual.MPG)
plot(a$Weight, a$Actual.MPG)
plot(a$Accelerate, a$Actual.MPG)
plot(a$Actual.MPG, a$Year)

#Executing the first model
model1 <- lm(Actual.MPG~., data = a)

#Checking the results
summary(model1)

#Checking for hetroskadasticity
plot(model1$fitted.values, model1$residuals)


plot(a$Cylinders, model1$residuals)
plot(a$Engine.Disp, model1$residuals)
plot(a$Horsepower, model1$residuals)
plot(a$Weight, model1$residuals)
plot(a$Accelerate, model1$residuals)

#Creating a new dataset
b <- a

#Correcting Hetroskadasticity

b$Horsepower <- log(a$Horsepower)
b$Actual.MPG <- log(a$Actual.MPG)
b$Engine.Disp <- log(a$Engine.Disp)
b$Weight <- log(a$Weight)

#Rebuilding the model
model2 <- lm(Actual.MPG~., data = b)

#Checking the results
summary(model2)

#Checking Hetroskadasticity
plot(model2$fitted.values, model2$residuals)
plot(b$Cylinders, model2$residuals)
plot(b$Engine.Disp, model2$residuals)
plot(b$Horsepower, model2$residuals)
plot(b$Weight, model2$residuals)
plot(b$Accelerate, model2$residuals)
