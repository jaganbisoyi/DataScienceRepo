### Setting Working Directory
setwd("C:\\D2WAP\\Training\\Analytics Accelerator\\Regression")
library(car)

##Read the data in the file
DefaultData <-read.csv("Linear_Regression.csv")

#Check what is there in the file

View(DefaultData)

#Check if the data is populated/imported properly
head(DefaultData)
tail(DefaultData)

#Check the summary of the file
summary(DefaultData)


#We will use the data which has been converted into bands and dummy variables. Read the final Data
DefaultData4<-read.csv("Linear_Reg_Sample_Data.csv")

#Look at the column Headings
names(DefaultData4)


#Create linear function for vif
vif_data<-lm(Capped_Losses~Years_Drv_Exp+Number_Vehicles+Average_Age+Gender_Dummy+Married_Dummy+Avg_Veh_Age+Fuel_Type_Dummy,data=DefaultData4)
summary(vif_data)
#Check Vif, vif>2 means presence of multicollinearity
vif(vif_data)

#Compare R-square of Average_Age and Years_Drv_Exp to check which performs better
age1<-lm(Capped_Losses~Average_Age,data=DefaultData4)
drv1<-lm(Capped_Losses~Years_Drv_Exp,data=DefaultData4)
summary(age1)
summary(drv1)
#keep Average_Age and remove Years_Drv_Exp
#In same way we can decide to keep Age band as compared to Age and Vehicle Age Band as compared to Vehicle Age

#Run Linear Regression w/o Years_Drv_Exp
lin_r1<-lm(Capped_Losses~Number_Vehicles+Average_Age+Gender_Dummy+Married_Dummy+Avg_Veh_Age+Fuel_Type_Dummy,data=DefaultData4)
vif(lin_r1)

#Let's look at the results
summary(lin_r1)