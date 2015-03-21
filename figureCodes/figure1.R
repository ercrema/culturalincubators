library(utils)
library(foreach)
library(doParallel)
registerDoParallel(cores=4)
source("~/github/culturalIncubators/src/CopytheBest.R")
source("~/github/culturalIncubators/src/CopyIfBetter.R")
source("~/github/culturalIncubators/src/RandomCopying.R")

## Do not Run but load the .RData file below:

## Model Execution #
#
#
#baseline=RC(k=1:150,c=0,z=1)
##Copy if Better
#CiB.Avg3Sigma1=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CiB(k=k,c=0,gi=3,gj=1,sigma=1,z=1)))/nsim}
#CiB.Avg3Sigma3=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CiB(k=k,c=0,gi=3,gj=1,sigma=3,z=1)))/nsim}
##Copy the Best
#CB.Avg3Sigma1=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CB(k=k,c=0,gi=3,gj=1,sigma=1,z=1)))/nsim}
#CB.Avg3Sigma3=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CB(k=k,c=0,gi=3,gj=1,sigma=3,z=1)))/nsim}
#
#
## With Innovation #
#baseline.c=RC(k=1:150,c=0.005,z=1)
##Copy if Better
#CiB.Avg3Sigma1.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CiB(k=k,c=0.005,gi=3,gj=1,sigma=1,z=1)))/nsim}
#CiB.Avg3Sigma3.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CiB(k=k,c=0.005,gi=3,gj=1,sigma=3,z=1)))/nsim}
##Copy the Best
#CB.Avg3Sigma1.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CB(k=k,c=0.005,gi=3,gj=1,sigma=1,z=1)))/nsim}
#CB.Avg3Sigma3.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(10000,CB(k=k,c=0.005,gi=3,gj=1,sigma=3,z=1)))/nsim}
#
#save.image("~/github/culturalIncubators/figureCodes/figure1.RData")


load("~/github/culturalIncubators/figureCodes/figure1.RData")

#Plot Figure 1#

par(mfrow=c(1,2))
plot(1:150,baseline,type="l",xlab="k",ylab="P(loss)",ylim=c(0,1),lty=1,lwd=2,main="a") #baseline RC
#CIB:
lines(1:150,CiB.Avg3Sigma1,lty=1,col="indianred",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CiB.Avg3Sigma3,lty=2,col="indianred",lwd=2) #Higher Payoff and Uncertainty (sigma 3, gj=2)
#CB 
lines(1:150,CB.Avg3Sigma1,lty=1,col="royalblue",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CB.Avg3Sigma3,lty=2,col="royalblue",lwd=2) #Higher Payoff# (sigma 3, gi=3)

plot(1:150,baseline.c,type="l",xlab="k",ylab="P(loss)",ylim=c(0,1),lty=1,lwd=2,main="b") #baseline RC
#CIB:
lines(1:150,CiB.Avg3Sigma1.c,lty=1,col="indianred",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CiB.Avg3Sigma3.c,lty=2,col="indianred",lwd=2) #Higher Payoff and Uncertainty (sigma 3, gj=2)
#CB 
lines(1:150,CB.Avg3Sigma1.c,lty=1,col="royalblue",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CB.Avg3Sigma3.c,lty=2,col="royalblue",lwd=2) #Higher Payoff# (sigma 3, gi=3)

legend("topright",legend=c("Random Copying",expression(paste("Copy if Better (",sigma,"=1)",sep="")),expression(paste("Copy if Better (",sigma,"=3)",sep="")),expression(paste("Copy the Best (",sigma,"=3)",sep="")),expression(paste("Copy the Best (",sigma,"=3)",sep=""))),lty=c(1,1,2,1,2),lwd=2,col=c("black","indianred","indianred","royalblue","royalblue"))

dev.print(device=pdf,"~/github/culturalIncubators/figures/figure1.pdf")
dev.print(device=png,"~/github/culturalIncubators/figures/figure1.png",width=740,height=400)
