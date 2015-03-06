

# Code for Figure 4 #

#Read Data (preliminary data with slightly less than 30,000 runs each)
model2<-read.csv("./data/incomplete/combinedResultsModel2.csv",col.names=c("id","sigma","z","mu","k","median","mean"))
#random2<-read.csv("./data/incomplete/combinedResultsRandom1.csv",col.names=c("id","sigma","z","mu","k","median","mean"))
#weighted2<-read.csv("./data/incomplete/combinedResultsWeighted1.csv",col.names=c("id","sigma","z","mu","k","median","mean"))



layout(matrix(c(1,2,3),nrow=1,ncol=3),width=c(1,1,0.4))

cc<-colorRampPalette(c("yellow","blue", "red"))
hiSigma<-subset(model2,sigma>=2.5)
loSigma<-subset(model2,sigma<=0.5)

hiSigma$col <- as.numeric(cut(hiSigma$mean, quantile(hiSigma$mean,prob=seq(0,1,0.1)),labels = 1:10))
loSigma$col <- as.numeric(cut(loSigma$mean, quantile(loSigma$mean,prob=seq(0,1,0.1)),labels = 1:10))

plot(k~z,col=adjustcolor(cc(10),alpha.f=0.3)[loSigma$col],data=loSigma,pch=20,cex=1,cex.main=1.4,cex.lab=1.5,ylim=c(0,500),main=expression(paste(sigma,"<0.5")))
plot(k~z,col=adjustcolor(cc(10),alpha.f=0.3)[hiSigma$col],data=hiSigma,pch=20,cex=1,cex.main=1.4,cex.lab=1.5,ylim=c(0,500),main=expression(paste("2.5<",sigma,"<3")))

par(mar=c(3,3,3,3))
plot(1,1,xlim=c(1,10),ylim=c(1,11), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='',main=expression(paste(bar(g)," percentile")))
axis(2, at=seq(0,10,1),labels=paste(seq(0,100,10),"th",sep=""), las=1)
for (i in 1:10) {
    	rect(0,i-0.5,10,i+0.5,col=cc(10)[i], border=NA)
    }

#test figure store
dev.print(device=pdf,"figures/testFigures/fig4.pdf")
