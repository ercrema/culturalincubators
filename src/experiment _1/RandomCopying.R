# Random Copying #
# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators

      

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


#Analytical Solution#

#The population size N is equal to k (number of social teacher) + 1 (self)
#probability of the innovator engaging into social learning : z
#probability that a non-innovator engage into social learning and copies the innovator without innovating : z/k * (1-c) 
#probability that a non-innovator engage into social learning and copies a non innovator without innovating : z*(k-1)/k * (1-c)
#probability that a non-innovator engage into social learning and copies the innovator innovating at the same time : z/k * c 
#probability that a non-innovator engage into social learning and copies a non innovator  innovating at the same time: z*(k-1)/k * c
#probability that a non-innovator does not engage into social learning without innovating: (1-z) * (1-c) 
#probability that a non-innovator does not engage into social learning innovating at the same time: (1-z) * c 

#final probability for non-innovator not innovating=  z*(k-1)/k * (1-c) + (1-z) * (1-c) = 1- (z/k + c - (z/k * c))
#final probability for non-innovator  innovating= z/k * (1-c) +  z/k * c  + z*(k-1)/k * c + (1-z) * c 

RC<-function(k,c,z)
    {
       return(z * (1- (z/k + c - (z/k * c))) ^ k)
    }


    
