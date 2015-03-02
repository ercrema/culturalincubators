# Unbiased Learning #
# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators

       #The population size N is equal to k (number of social teacher) + 1 (self)
       #probability of the innovator engaging into social learning : z
       #probability that a non-innovator  engage into social learning and copies the innovator : z*1/k
       #probability of innnovating minus probability of innovating and copying the innovator: c -(z/k*c)
       #raise to the power of k to compute the probability for all agents except the innovator 

UBanaltycal<-function(k,c,z)
    {
       return(z * (1 - z/k + c - (z/k * c)) ^ k)
    }



    
