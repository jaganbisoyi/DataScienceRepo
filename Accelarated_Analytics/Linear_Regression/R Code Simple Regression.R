
# Reading the data
Data1 <- read.csv("C:\\D2WAP\\Training\\Analytics Accelerator\\Regression\\cars.csv")

# Running the model
model1 <- lm(Actual.MPG ~ Weight, data = Data1)

# Checking the result
summary(model1)