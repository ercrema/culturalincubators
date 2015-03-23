

# Code for Figure 3 #

#Read Data (preliminary data with slightly less than 30,000 runs each)
model3<-read.csv("./data/combinedResultsModel3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))
random3<-read.csv("./data/combinedResultsRandom3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))
weighted3<-read.csv("./data/combinedResultsWeighted3.csv",col.names=c("id","N","sigma","k","mu","z","mean","median"))



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
        cb1000=subset(model3,sigma==sigmas[x]&N==1000)
        cb1000Fit<-loess(mean~k,cb1000,)
        cb2000=subset(model3,sigma==sigmas[x]&N==2000)
        cb2000Fit<-loess(mean~k,cb2000)
        cb4000=subset(model3,sigma==sigmas[x]&N==4000)
        cb4000Fit<-loess(mean~k,cb4000)
     
        cib1000=subset(weighted3,sigma==sigmas[x]&N==1000)
        cib1000Fit<-loess(mean~k,cib1000)       
        cib2000=subset(weighted3,sigma==sigmas[x]&N==2000)
        cib2000Fit<-loess(mean~k,cib2000)               
        cib4000=subset(weighted3,sigma==sigmas[x]&N==4000)        
        cib4000Fit<-loess(mean~k,cib4000)               

        
        #rc1000=subset(random3,sigma==sigmas[x]&N==1000)
        #rc2000=subset(random3,sigma==sigmas[x]&N==2000)
        #rc4000=subset(random3,sigma==sigmas[x]&N==4000) 

        maxY<-max(c(cb1000$mean,cb2000$mean,cb4000$mean,cib1000$mean,cib2000$mean,cib4000$mean,rc1000$mean,rc2000$mean,rc4000$mean))        
        plot(mean~k,pch=20,col="pink",ylab="",xlab="",data=cb1000,axes=F,ylim=c(0,maxY),main=title[x])

        points(mean~k,pch=20,col="red",data=cb2000)
        points(mean~k,pch=20,col="darkred",data=cb4000)

        points(mean~k,pch=20,col="lightblue",data=cib1000)
        points(mean~k,pch=20,col="blue",data=cib2000)
        points(mean~k,pch=20,col="darkblue",data=cib4000)
        
        
        axis(side=1,at=seq(0,500,100),labels=seq(0,500,100),padj=-1,tcl=-0.4)
        axis(side=2,padj=1,tcl=-0.4)
        mtext(side=1,text="k",line=1.3)
        mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
        box()
        if(x==1)
            legend("right",legend=c("CopyTheBest N=1000","CopyTheBest N=2000","CopyTheBest N=4000",
                                    "CopyIfBetter N=1000","CopyIfBetter N=1000","CopyIfBetter N=1000"),
                   fill=c("pink","red","darkred","lightblue","blue","darkblue"))

    }

#test figure store
dev.print(device=pdf,"./figures/figure4.pdf")
dev.print(device=png,"./figures/figure4.png",width=550,height=550)
