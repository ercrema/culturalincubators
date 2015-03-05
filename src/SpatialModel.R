
#################
# Spatial Model #
#################

# Core Simulation #
# mat ... interaction matrix
# z ... frequency of cultural transmission
# mu ... innovation rate
# sigma ... phenotypic variance
# timeSteps ... number of timesteps


sim<-function(mat,z=1,mu=0.01,sigma=2,timeSteps=1000,verbose=FALSE,mode=c("random","weighted","model"))
    {
        mat[which(mat==0,TRUE)]=NA
        N=nrow(mat) #retrieve number of agents
        Genotype=rep(0,N) #define initial genotype
        if (verbose==TRUE) {pb <- txtProgressBar(min = 1, max = timesteps, style = 3)}

        for (t in 1:timeSteps)
            {
                if (verbose==TRUE) {setTxtProgressBar(pb, t)}        
                #Expression#
                payoff<-rnorm(N,mean=Genotype,sd=sigma)
                
                #Transmission#
                index<-c(runif(N)<z) #index of agents copying
                if (length(index)>0){
                    if (mode=="random")
                        {
                            Genotype[index]<-sapply(which(index),function(x,mat,Genotype)
                                {
                                    if (sum(mat[1,],na.rm=TRUE)==1) {return(Genotype[which(mat[x,]==1)])} #Select the other genotype
                                    if (sum(mat[1,],na.rm=TRUE)>1)  {return(sample(Genotype[which(mat[x,]==1)],size=1,replace=TRUE))} #Randomly Sample genotype
                                },mat=mat,Genotype=Genotype)
                        }


                    
                    if (mode=="weighted")
                        {
                            Genotype[index]<-sapply(which(index),function(x,mat,Genotype,payoff)
                                {
                                    res=Genotype[x] #Define default (retaining genotype)
                                    #Define Teacher
                                    if (sum(mat[1,],na.rm=TRUE)==1) {teacher=which(mat[x,]==1)}
                                    if (sum(mat[1,],na.rm=TRUE)>1) {teacher=sample(which(mat[x,]==1),size=1,replace=TRUE)}
                                    #Comparison
                                    if (payoff[teacher]>payoff[x]){res=Genotype[teacher]}
                                    return(res)
                                },mat=mat,Genotype=Genotype,payoff=payoff)
                        }


                    
                    if (mode=="model")
                        {
                            Genotype[index]=sapply(which(index),function(x,mat,Genotype,payoff)
                                {
                                    res=Genotype[x] #Define default (retaining genotype)
                                    tmp.index=which(mat[x,]==1) #define pool of teachers
                                    if (max(payoff[tmp.index])>payoff[x]) 
                                        {
                                            res=Genotype[which(payoff==max(payoff[tmp.index]))]
                                        }
                                    return(res)
                                },mat=mat,Genotype=Genotype,payoff=payoff)
                        }

                }
                
                #Innovation#
                index=which(runif(N)<mu)
                Genotype[index]=Genotype[index]+1

                if (verbose==TRUE) {close(pb)}
                return(mean(Genotype))
            }



#### Utility Functions ####

# Generate Random Points in a Space of 1 x 1 and its distance matrix
randomPoints<-function(N)
    {
        x<-runif(N)
        y<-runif(N)
        distMatrix<-as.matrix(dist(cbind(x,y)))
        return(distMatrix)
    }

# Generate Neighbour Matrix based on k-nearest agents
matrixGenerator<-function(distMatrix,k)
    {
        Kmatrix<-t(apply(distMatrix,1,function(x,k){
        res<-rep(0,length(x))
        res[order(x)[1:(k+1)]]=1         
        return(res)
        },k=k))
        diag(Kmatrix)=0
        return(Kmatrix)
    }
