#Load Source File
#-the source file is a .RData file where all the functions and codes are preloaded
place<-getwd()
source("/home/tcrnerc/Scratch/models/incubator/SpatialModel.R") #load ABM
load("/home/tcrnerc/Scratch/models/incubator/sweep3.RData") #load sweep
setwd(place)#Load Source File

#This allows the definition of arguments (this allows the definition of the random seeds as an input argument)
Args<-as.numeric(commandArgs(TRUE))
NewArgs=c(150,151,152,154,159,160,162,167,168,171); Args=NewArgs[Args]
set.seed(Args)
number.sim.per.job = 3

#Subset sweep for current run 
thissweep<-as.data.frame(paramsweep[((Args-1)*number.sim.per.job+1):(Args*number.sim.per.job),])
resultMean<-numeric() #place holder for containing results
resultMedian<-numeric() #place holder for containing results

#Simulation loop
for (x in 1:number.sim.per.job)
    {
print(x)
result<-sim(mat=matrixGenerator(randomPoints(thissweep$N[x]),k=thissweep$k[x]),
            z=thissweep$z[x],mu=thissweep$mu[x],sigma=thissweep$sigma[x],
            timeSteps=1000,verbose=TRUE,mode="weighted")
resultMean[x]=result[1]
resultMedian[x]=result[2]
    }


#When the computation is done, create the name of the RData as the name of the calling code...
thissweep$Mean=resultMean
thissweep$Median=resultMedian

name<-paste("./res",Args,".csv",sep="")
write.csv(thissweep,file=name)
