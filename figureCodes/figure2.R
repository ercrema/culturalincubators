source("./src/SpatialModel.R")

N=1000
k=100
x<-runif(N)
y<-runif(N)
distMatrix<-as.matrix(dist(cbind(x,y)))
neighbours=matrixGenerator(distMatrix=distMatrix,k=k)
locations<-data.frame(id=1:N,x=x,y=y)

#Define Sample pools
i=subset(locations,x>0.35&x<0.45&y>0.35&y<0.45)$id[1]
j=subset(locations,x>0.45&x<0.65&y>0.40&y<0.60)$id[1]

shared.pool=which(apply(neighbours[c(i,j),],2,sum)==2)
pool.j=which(neighbours[j,]==1)
pool.j=pool.j[-which(pool.j%in%shared.pool)]
pool.i=which(neighbours[i,]==1)
pool.i=pool.i[-which(pool.i%in%shared.pool)]
rest=c(1:N)[-c(pool.j,pool.i,shared.pool)]


#plot
plot(x[rest],y[rest],pch=20,col=rgb(0,0,0,0.05),ylim=c(0,1),xlim=c(0,1),xlab="x",ylab="y")
points(x[i],y[i],pch=15,col="red",cex=1.3)
points(x[j],y[j],pch=15,col=rgb(0,0,1,1),cex=1.3)


points(x[pool.i],y[pool.i],pch=20,col=rgb(1,0,0,0.2),cex=1.3)
points(x[pool.j],y[pool.j],pch=20,col=rgb(0,0,1,0.2),cex=1.3)
points(x[shared.pool],y[shared.pool],pch=20,col=rgb(0,1,0,0.2),cex=1.3)

dev.print(device=pdf,"./figures/figure2.pdf")
dev.print(device=png,"./figures/figure2.png",width=350,height=400)
