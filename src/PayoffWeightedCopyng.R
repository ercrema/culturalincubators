# Payoff-Weighted Learning #
# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators
# gi ... payoff of the innovator
# gj ... payoff of the others

PW<-function(k,c,z,gi,gj,sigma)
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

