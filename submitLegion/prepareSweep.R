# The prepareSweep function 




# Holding z constant #
library(tgp)
v=c(0,3)
b=c(1)
z=c(1)
mu=c(0.005)
k=c(1,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(v,b,z,mu,k))
colnames(paramsweep)<-c("v","b","z","mu","k")
paramsweep[,5]<-round(paramsweep[,5])
save(paramsweep,file="./submitLegion/sweep1.RData")

# Sweeping z #
v=c(0,3)
b=c(1)
z=c(0,1)
mu=c(0.005)
k=c(1,500)
number.sim.per.job=3
number.jobs=10000
paramsweep<-lhs(number.sim.per.job*number.jobs,rect=rbind(v,b,z,mu,k))
colnames(paramsweep)<-c("v","b","z","mu","k")
paramsweep[,5]<-round(paramsweep[,5])
save(paramsweep,file="./submitLegion/sweep2.RData")



#################################################
