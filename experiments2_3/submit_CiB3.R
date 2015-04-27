#Load Source Files and Parameter Sweep

source("./src.R") #load ABM
load("./experiments2_3/sweepExp3.RData") #load sweep

resultMean<-numeric() #place holder for containing results
resultMedian<-numeric() #place holder for containing results


#################################################################################
# Code for Complete Execution (note: extremely slow with larger parameter space #
#################################################################################
paramsweep=as.data.frame(paramsweep)
for (x in 1:nrow(paramsweep))
    {
        result<-sim(mat=matrixGenerator(randomPoints(paramsweep$N[x]),k=paramsweep$k[x]),
                    z=paramsweep$z[x],mu=paramsweep$mu[x],sigma=paramsweep$sigma[x],
                    timeSteps=1000,verbose=FALSE,mode="CopyIfBetter")
        resultMean[x]=result[1]
        resultMedian[x]=result[2]
    }

paramsweep$Mean=resultMean
paramsweep$Median=resultMedian

write.csv(paramsweep,file="./results/Exp3CopyIfBetter.csv")



###############################
# Code for array job on a HPC #
###############################


#Args is the command line argument pointing to the thread number, which is used as seed
Args<-as.numeric(commandArgs(TRUE))
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
                    timeSteps=1000,verbose=TRUE,mode="CopyIfBetter")
        resultMean[x]=result[1]
        resultMedian[x]=result[2]
    }


thissweep$Mean=resultMean
thissweep$Median=resultMedian

#Store individual jobs with the seed as part of the name. This should be later bound to a single file
name<-paste("./res",Args,".csv",sep="")
write.csv(thissweep,file=name)
