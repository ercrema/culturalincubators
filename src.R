##############################################################################
# Title: Simulation Source Codes and Utility functions for the paper: "Cultural Incubators and the Spread of Innovation", authored by E.Crema and M.Lake, submitted to Human Biology
#
# Version: 1.0
# Author:   Enrico R. Crema 
#           CaSEs Research Group - Department of HUmanities
#           Universitat Pompeu Fabra (UPF)
#           UCL Institute of Archaeology
#           enrico.crema@gmail.com
#           ---
#           Mark W. Lake
#           UCL Institute of Archaeology
#           mark.lake@ucl.ac.uk



# Date: 27/04/2015
##############################################################################



#######################################################
# Probability of Innovation Loss Models (experiment 1 #
#######################################################

# The following functions (except RC()) returns a TRUE/FALSE statement on whether the the innovator's trait is lost (TRUE) or retained (FALSE) in the entire population. Notice that N is equal to k+1.
# The function RC() returns the exact probability of trait loss obtained from an analtycal solution
# The functions are used in experiment #1 of the paper.

#***  Copy-if-Better Learning ***#

# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators
# sigma ... payoff uncertainty
# gi ... payoff of the innovator
# gj ... payoff of the others

CiB<-function(k,c,z,gi,gj,sigma)
    {
        #Sample Payoffs
        innovatorPayoff=rnorm(1,mean=gi,sd=sigma)
        otherPayoffs=rnorm(k,mean=gj,sd=sigma)

        #Set default conditions
        InnovatorRetain=TRUE
        OthersChange=rep(FALSE,k)
        
        #Innovator reverting to suboptimal trait:
        if (runif(1)<z & sample(c("a",rep("b",k)),1)=="b" & innovatorPayoff < otherPayoffs[sample(k,1)])
            {InnovatorRetain=FALSE}

        #Others shifting to new trait: transmission
        index=which(runif(k)<z)
        if (length(index)>0)
            {
                for (i in 1:length(index))
                    {
                if(sample(c("a",rep("b",k-1)),1)=="a" & (otherPayoffs[index[i]]<innovatorPayoff))
                   OthersChange[index[i]]=TRUE
                    }
            }
        
        #Others shifting to new trait: convergent innovation
        index=which(runif(k)<c)
        OthersChange[index]=TRUE
    

        #return TRUE/FALSE
        return(all(c(InnovatorRetain,OthersChange)==FALSE))
    }


#***  Copy-the-Best Learning ***#

# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators
# sigma ... payoff uncertainty
# gi ... payoff of the innovator
# gj ... payoff of the others

CB<-function(k,c,z,gi,gj,sigma)
    {
        #Sample Payoffs
        innovatorPayoff=rnorm(1,mean=gi,sd=sigma)
        otherPayoffs=rnorm(k,mean=gj,sd=sigma)

        #Set default conditions
        InnovatorRetain=TRUE
        OthersChange=rep(FALSE,k)
        
        #Innovator reverting to suboptimal trait:
        if (runif(1)<z & innovatorPayoff < max(otherPayoffs))
            {InnovatorRetain=FALSE}

        #Others shifting to new trait: transmission
        index=which(runif(k)<z)
        if (length(index)>0)
            {
                for (i in 1:length(index))
                    {
                if(max(otherPayoffs)<innovatorPayoff) #Notice that there is no need to use the focal payoff here
                   OthersChange[index[i]]=TRUE
                    }
            }
        
        #Others shifting to new trait: convergent innovation
        index=which(runif(k)<c)
        OthersChange[index]=TRUE
    

        #return TRUE/FALSE
        return(all(c(InnovatorRetain,OthersChange)==FALSE))
    }


#***  Random Copying ***#


# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators

#Simulation#      
RCsim<-function(k,c,z)
    {
        #Set default conditions
        InnovatorRetain=TRUE
        OthersChange=rep(FALSE,k)

        #Innovator reverting to suboptimal trait:
        if (runif(1)<z)
            {InnovatorRetain=FALSE}
        
        #Others shifting to new trait: transmission
        index=which(runif(k)<z)
        if (length(index)>0)
            {
                for (i in 1:length(index))
                    {
                if(sample(c("a",rep("b",k-1)),1)=="a")
                   OthersChange[index[i]]=TRUE
                    }
            }
        #Others shifting to new trait: convergent innovation
        index=which(runif(k)<c)
        OthersChange[index]=TRUE
        
        #return TRUE/FALSE
        return(all(c(InnovatorRetain,OthersChange)==FALSE))
    }

#Analtyical Solution#      

RC<-function(k,c,z)
    {
       return(z * (1- (z/k + c - (z/k * c))) ^ k)
    }



###############################################
# Rate of Evolution Models (experiment 2 & 3) #
###############################################
# The function sim() returns the average value of the parameter "g" for given settings of k, mu, and z, and given mode of social learning after timeSteps iterations. 
# The functions are used in experiment #2 and #3 of the paper.

# Main Function #
# mat ... interaction matrix (output of the matrixGenerator() function)
# z ... frequency of cultural transmission
# mu ... innovation rate
# sigma ... payoff uncertainty
# timeSteps ... number of timesteps
# mode ... mode of transmission, either "Random", "CopyIfBetter", or "CopyTheBest"
# verbose ... if set to TRUE shows a progressbar




sim<-function(mat,z=1,mu=0.01,sigma=2,timeSteps=1000,verbose=FALSE,mode=c("Random","CopyIfBetter","CopyTheBest"))
    {
        mat[which(mat==0,TRUE)]=NA
        N=nrow(mat) #retrieve number of agents
        Genotype=rep(0,N) #define initial genotype
        if (verbose==TRUE) {pb <- txtProgressBar(min = 1, max = timeSteps, style = 3)}

        for (t in 1:timeSteps)
            {
                if (verbose==TRUE) {setTxtProgressBar(pb, t)}        
                                        #Expression#
                payoff<-rnorm(N,mean=Genotype,sd=sigma)
                
                                        #Transmission#
                index<-c(runif(N)<z) #index of agents copying
                if (any(index)){
                    if (mode=="Random")
                        {
                            Genotype[index]<-sapply(which(index),function(x,mat,Genotype)
                                {
                                    if (sum(mat[1,],na.rm=TRUE)==1) {return(Genotype[which(mat[x,]==1)])} #Select the other genotype
                                    if (sum(mat[1,],na.rm=TRUE)>1)  {return(sample(Genotype[which(mat[x,]==1)],size=1,replace=TRUE))} #Randomly Sample genotype
                                },mat=mat,Genotype=Genotype)
                        }


                    
                    if (mode=="CopyIfBetter")
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


                    
                    if (mode=="CopyTheBest")
                        {
                            Genotype[index]=sapply(which(index),function(x,mat,Genotype,payoff)
                                {
                                    res=Genotype[x] #Define default (retaining genotype)
                                    tmp.index=which(mat[x,]==1) #define pool of teachers
                                    if (max(payoff[tmp.index])>payoff[x]) 
                                        {
                                            target=which(payoff==max(payoff[tmp.index]))
                                            if(length(target)>1){target=sample(target,size=1)}
                                            res=Genotype[target]
                                        }
                                    return(res)
                                },mat=mat,Genotype=Genotype,payoff=payoff)
                        }

                }
                
                                        #Innovation#
                index=which(runif(N)<mu)
                Genotype[index]=Genotype[index]+1
            }
        if (verbose==TRUE) {close(pb)}
        return(mean(Genotype))
    }




# Generate N Random Points in a Space of 1 x 1 and returns a distance matrix
randomPoints<-function(N)
    {
        x<-runif(N)
        y<-runif(N)
        distMatrix<-as.matrix(dist(cbind(x,y)))
        return(distMatrix)
    }

# Generate Neighbour Matrix based on k-nearest points (k) and a distance Matrix (distMatrix, output of randomPoints())
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
