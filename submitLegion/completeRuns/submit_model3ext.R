#Load Source File
#-the source file is a .RData file where all the functions and codes are preloaded
place<-getwd()
source("/home/tcrnerc/Scratch/models/incubator/SpatialModel.R") #load ABM
load("/home/tcrnerc/Scratch/models/incubator/sweep3.RData") #load sweep
setwd(place)#Load Source File

#This allows the definition of arguments (this allows the definition of the random seeds as an input argument)
Args<-as.numeric(commandArgs(TRUE))

NewArgs=c(1285,2257,2813,2815,3393,4323,4743,4795,5222,5223,5282,5889,5902,5974,6470,6515,6662,7269,7305,7335,7392,7757,7812,8255,8281,8284,8287,8561,8906,8927,9020,9112,9427,9462,9578,9640,9785,9877)

Args=NewArgs[Args]
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
            timeSteps=1000,verbose=TRUE,mode="model")
resultMean[x]=result[1]
resultMedian[x]=result[2]
    }


#When the computation is done, create the name of the RData as the name of the calling code...
thissweep$Mean=resultMean
thissweep$Median=resultMedian

name<-paste("./res",Args,".csv",sep="")
write.csv(thissweep,file=name)
