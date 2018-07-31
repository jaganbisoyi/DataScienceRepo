###
setwd("C:\\D2WAP\\Training\\Analytics Accelerator\\Clustering & Segmentation")
install.packages("amap")
library(amap)
##Read the data in the file
cust_data<-read.csv("Insurance.csv")
### Select the requried columns for clustering
cust_data<-cust_data[,c(1,2,4,5,7,9,10,13)]

###Run the kmeans algorithm to generate the clusters
k1<-Kmeans(cust_data[,-c(1)],3, iter.max = 200, method = c("euclidean"))
names(k1)

###See the clustering results
###Fetch the group means for each variable
k1$centers

###Fetch size/n of obs for the groups
k1$size
###Fetch sum of squared  for the groups
k1$withinss

par(mfrow=c(1,3), mar=c(3,4,4,2))

cust_data$cluster <- k1$cluster
cust_data$clusterfactor <- as.factor(k1$cluster)
boxplot(cust_data$Age~ cust_data$clusterfactor, data = cust_data, main = "Age Distribution by Clusters", xlab = "Clusters", ylab = " Age")

boxplot(cust_data$Years.of.Driving.Experience~ cust_data$clusterfactor, data = cust_data, main = "Driving Experience by Clusters", xlab = "Clusters", ylab = " Driving Experience")

boxplot(cust_data$Vehicle.Age~ cust_data$clusterfactor, data = cust_data, main = "Vehicle Age by Clusters", xlab = "Clusters", ylab = " Vehicle Age")

write.csv(cust_data, "clustering.csv")

plot (cust_data$Age, cust_data$Years.of.Driving.Experience, col= k1$cluster)
points(k1$centers, pch=20)

# Check the right number of clusters
wss =20

for (i in 2:15) wss[i]=sum(kmeans(cust_data[,-c(1)],centers=i)$withinss)

plot(2:15, wss[2:15], type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")