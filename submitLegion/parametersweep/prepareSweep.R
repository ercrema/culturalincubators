# The prepareSweep function 
# Holding z constant #
setwd("./culturalincubators/")
library(tgp)
sigma=c(0,3)
z=c(1)
mu=c(0.005)
k=c(0,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(sigma,z,mu,k))
colnames(paramsweep)<-c("sigma","z","mu","k")
paramsweep[,4]<-ceiling(paramsweep[,4])
save(paramsweep,file="./submitLegion/parametersweep/sweep1.RData")

# Sweeping z #
sigma=c(0,3)
z=c(0,1)
mu=c(0.005)
k=c(0,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(sigma,z,mu,k))
colnames(paramsweep)<-c("sigma","z","mu","k")
paramsweep[,4]<-ceiling(paramsweep[,4])
save(paramsweep,file="./submitLegion/parametersweep/sweep2.RData")


# Sweeping N #
N=c(0,3)
sigma=c(0,4)
k=c(0,500)
mu=c(0.005)
z=1
number.sim.per.job=3
number.jobs=10000

paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(N,sigma,k,mu,z))
paramsweep[,1]<-ceiling(paramsweep[,1])
paramsweep[,2]<-ceiling(paramsweep[,2])
paramsweep[,3]<-ceiling(paramsweep[,3])
paramsweep[which(paramsweep[,1]==1),1]=1000
paramsweep[which(paramsweep[,1]==2),1]=2000
paramsweep[which(paramsweep[,1]==3),1]=4000
paramsweep[which(paramsweep[,2]==1),2]=0
paramsweep[which(paramsweep[,2]==2),2]=0.4
paramsweep[which(paramsweep[,2]==3),2]=1.5
paramsweep[which(paramsweep[,2]==4),2]=4
colnames(paramsweep)<-c("N","sigma","k","mu","z")

save(paramsweep,file="./submitLegion/parametersweep/sweep3.RData")

#################################################
