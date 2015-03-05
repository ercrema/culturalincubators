# Copy the Best #
# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators
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

