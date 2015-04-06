

# Code for Figure 3 #

#Read Data (preliminary data with slightly less than 30,000 runs each)
model3<-read.csv("./data/combinedResultsModel3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))
random3<-read.csv("./data/combinedResultsRandom3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))
weighted3<-read.csv("./data/combinedResultsWeighted3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))


model3$Nk<-model3$N/model3$k
random3$Nk<-random3$N/random3$k
weighted3$Nk<-weighted3$N/weighted3$k


# Define Parameter Settings
par(mfrow=c(2,2))
par(mar=c(3,3,1,1))


# Define Titles
title<-vector("list",length=4)
title[1]=expression(paste(sigma,"=0"))
title[2]=expression(paste(sigma,"=0.4"))
title[3]=expression(paste(sigma,"=1.5"))
title[4]=expression(paste(sigma,"=4"))

sigmas=c(0,0.4,1.5,4)

# plotting for loop
for (x in 1:4)
    {
# subset data based         
        cb=subset(model3,sigma==sigmas[x])
        cib=subset(weighted3,sigma==sigmas[x])

  
        maxY<-max(c(cb$mean,cib$mean))
                  
        plot(mean~Nk,pch=20,col="red",ylab="",xlab="",data=cb,axes=F,ylim=c(0,maxY),main=title[x])
        points(mean~Nk,pch=20,col="royalblue",data=cib)
              
        axis(side=1,at=seq(2,4000,500),labels=seq(2,4000,500),padj=-1,tcl=-0.4)
        axis(side=2,padj=1,tcl=-0.4)
        mtext(side=1,text="N/k",line=1.3)
        mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
        box()
        if(x==1)
        legend("topright",legend=c("CopyTheBest","CopyIfBetter"),fill=c("red","royalblue"))

    }

#test figure store
dev.print(device=pdf,"./figures/figure5.pdf")
dev.print(device=png,"./figures/figure5.png",width=550,height=550)



cb=subset(model3,sigma==sigmas[4])
cb1=subset(model3,sigma==sigmas[4]&N==1000)
cb2=subset(model3,sigma==sigmas[4]&N==2000)
cb3=subset(model3,sigma==sigmas[4]&N==4000)


par(mfrow=c(1,3))
plot(mean~Nk,pch=20,col=1,ylab=expression(bar(g)),xlab="N/k",data=cb,axes=TRUE,ylim=c(0,maxY),main="a",xlim=c(1,20))
plot(mean~Nk,pch=20,col=1,ylab=expression(bar(g)),xlab="N/k",data=cb,axes=TRUE,ylim=c(0,maxY),main="b",xlim=c(21,100))
plot(mean~Nk,pch=20,col=1,ylab=expression(bar(g)),xlab="N/k",data=cb,axes=TRUE,ylim=c(0,maxY),main="b",xlim=c(101,1500))
dev.print(device=pdf,"./Desktop/bw.pdf")

par(mfrow=c(1,3))
plot(mean~Nk,pch=20,col=rgb(1,0,0,0.1),ylab="",xlab="",data=cb1,axes=F,ylim=c(0,maxY),main="c",xlim=c(1,20))
points(mean~Nk,pch=20,col=rgb(0,0,1,0.1),data=cb2)
points(mean~Nk,pch=20,col=rgb(0,1,0,0.1),data=cb3)
mtext(side=1,text="N/k",line=1.3)
mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
axis(side=1,at=seq(1,20,5),labels=seq(1,20,5),padj=-1,tcl=-0.4)
axis(side=2,padj=1,tcl=-0.4)
box()
     

plot(mean~Nk,pch=20,col=rgb(1,0,0,0.1),ylab="",xlab="",data=cb1,axes=F,ylim=c(0,maxY),main="d",xlim=c(21,100))
points(mean~Nk,pch=20,col=rgb(0,0,1,0.1),data=cb2)
points(mean~Nk,pch=20,col=rgb(0,1,0,0.1),data=cb3)
mtext(side=1,text="N/k",line=1.3)
mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
axis(side=1,at=seq(20,100,20),labels=seq(20,100,20),padj=-1,tcl=-0.4)
axis(side=2,padj=1,tcl=-0.4)
box()


plot(mean~Nk,pch=20,col=rgb(1,0,0,0.1),ylab="",xlab="",data=cb1,axes=F,ylim=c(0,maxY),main="d",xlim=c(101,1500))
points(mean~Nk,pch=20,col=rgb(0,0,1,0.1),data=cb2)
points(mean~Nk,pch=20,col=rgb(0,1,0,0.1),data=cb3)
mtext(side=1,text="N/k",line=1.3)
mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
axis(side=1,at=seq(100,1500,200),labels=seq(100,1500,200),padj=-1,tcl=-0.4)
axis(side=2,padj=1,tcl=-0.4)
box()


legend("topright",legend=c("N=1000","N=2000","N=4000"),pch=20,col=c("red","blue","green"))
dev.print(device=pdf,"./Desktop/col.pdf")
