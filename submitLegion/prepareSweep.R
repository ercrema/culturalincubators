# The prepareSweep function 




# Holding z constant #
library(tgp)
sigma=c(0,3)
z=c(1)
mu=c(0.005)
k=c(1,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(sigma,z,mu,k))
colnames(paramsweep)<-c("sigma","z","mu","k")
paramsweep[,4]<-round(paramsweep[,4])
save(paramsweep,file="./submitLegion/sweep1.RData")

# Sweeping z #
sigma=c(0,3)
z=c(0,1)
mu=c(0.005)
k=c(1,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(sigma,z,mu,k))
colnames(paramsweep)<-c("sigma","z","mu","k")
paramsweep[,4]<-round(paramsweep[,4])
save(paramsweep,file="./submitLegion/sweep2.RData")



#################################################
