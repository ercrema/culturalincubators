load("./experiment1/experiment1.RData")

par(mfrow=c(1,2))
plot(1:150,baseline,type="l",xlab="k",ylab="P(loss of B)",ylim=c(0,0.8),lty=1,lwd=2,main="a") #baseline RC
#CIB:
lines(1:150,CiB.Avg3Sigma05,lty=1,col="indianred",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CiB.Avg3Sigma1,lty=2,col="indianred",lwd=2) #Higher Payoff and Uncertainty (sigma 3, gj=2)
#CB 
lines(1:150,CB.Avg3Sigma05,lty=1,col="royalblue",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CB.Avg3Sigma1,lty=2,col="royalblue",lwd=2) #Higher Payoff# (sigma 3, gi=3)

plot(1:150,baseline.c,type="l",xlab="k",ylab="P(loss)",ylim=c(0,1),lty=1,lwd=2,main="b") #baseline RC
#CIB:
lines(1:150,CiB.Avg3Sigma05.c,lty=1,col="indianred",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CiB.Avg3Sigma1.c,lty=2,col="indianred",lwd=2) #Higher Payoff and Uncertainty (sigma 3, gj=2)
#CB 
lines(1:150,CB.Avg3Sigma05.c,lty=1,col="royalblue",lwd=2) #Higher Payoff# (sigma 1, gi=3)
lines(1:150,CB.Avg3Sigma1.c,lty=2,col="royalblue",lwd=2) #Higher Payoff# (sigma 3, gi=3)

legend("topright",legend=c("Random Copying",expression(paste("Copy if Better (",sigma,"=0.5)",sep="")),expression(paste("Copy if Better (",sigma,"=1)",sep="")),expression(paste("Copy the Best (",sigma,"=0.5)",sep="")),expression(paste("Copy the Best (",sigma,"=1)",sep=""))),lty=c(1,1,2,1,2),lwd=2,col=c("black","indianred","indianred","royalblue","royalblue"))
#dev.print(device=pdf,"./figure2.pdf")

