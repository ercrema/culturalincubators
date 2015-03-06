

# Code for Figure 3 #

#Read Data (preliminary data with slightly less than 30,000 runs each)
model1<-read.csv("./data/incomplete/combinedResultsModel1.csv",col.names=c("id","sigma","z","mu","k","median","mean"))
#random1<-read.csv("./data/incomplete/combinedResultsRandom1.csv",col.names=c("id","sigma","z","mu","k","median","mean"))
#weighted1<-read.csv("./data/incomplete/combinedResultsWeighted1.csv",col.names=c("id","sigma","z","mu","k","median","mean"))

# Define Break points for a 2 x 5 figure
X<-seq(0,3,length.out=11)

# Define Parameter Settings
par(mfrow=c(2,5))
par(mar=c(3,3,1,1))

# Generate Color Ramp Function
cm<-colorRampPalette(c("lightpink", "red"))
cr<-colorRampPalette(c("khaki1", "orange"))
cc<-colorRampPalette(c("lightblue", "darkblue"))

# Define Titles
title<-vector("list",length=c(length(X)-1))
title[1]=expression(paste("0<",sigma,"<0.3"))
title[2]=expression(paste("0.3<",sigma,"<0.6"))
title[3]=expression(paste("0.6<",sigma,"<0.9"))
title[4]=expression(paste("0.9<",sigma,"<1.2"))
title[5]=expression(paste("1.2<",sigma,"<1.5"))
title[6]=expression(paste("1.5<",sigma,"<1.8"))
title[7]=expression(paste("1.8<",sigma,"<2.1"))
title[8]=expression(paste("2.1<",sigma,"<2.4"))
title[9]=expression(paste("2.4<",sigma,"<2.7"))
title[10]=expression(paste("2.7<",sigma,"<3"))


# plotting for loop
for (x in 1:c(length(X)-1))
    {
# subset data based         
smdata=subset(model1,sigma>X[x]&sigma<c(X[x+1]))
col <- as.numeric(cut(smdata$sigma, quantile(smdata$sigma,prob=seq(0,1,0.1)),labels = 1:10))
colours<-adjustcolor(cm(10),alpha.f=1)[col]
plot(mean~k,pch=20,col=colours,ylab=expression(bar(g)),xlab="k",data=smdata,main=title[x],axes=F)
axis(side=1,at=seq(0,500,100),labels=seq(0,500,100),padj=-1,tcl=-0.4)
axis(side=2,padj=1,tcl=-0.4)
mtext(side=1,text="k",line=1.3)
mtext(side=2,text=expression(bar(g)),line=1.5,las=2)
box()

#scdata=subset(weighted1,sigma>X[x]&sigma<c(X[x+1]))
#col <- as.numeric(cut(scdata$sigma, quantile(scdata$sigma,prob=seq(0,1,0.1)),labels = 1:10))
#colours<-adjustcolor(cc(10),alpha.f=1)[col]
#points(mean~k,pch=20,col=colours,data=scdata)

#srdata=subset(random1,sigma>X[x]&sigma<c(X[x+1]))
#col <- as.numeric(cut(srdata$sigma, quantile(srdata$sigma,prob=seq(0,1,0.1)),labels = 1:10))
#colours<-adjustcolor(cr(10),alpha.f=1)[col]
#points(mean~k,pch=20,col=colours,data=srdata)

#lines(k,predict(fit,mdata.frame(k=k)),col="red",lwd=2)
}
