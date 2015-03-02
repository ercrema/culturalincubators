# Payoff-Weighted Learning #
# Model parameters:
# k ... number of social teachers
# z ... probability of social learning
# c ... probability of convergent evolution for the non-innovators
# gi ... payoff of the innovator
# gj ... payoff of the others

PWanaltycal<-function(k,c,z)
    {
        #Probabilty Innovator losing the trait 
        InnovatorLoss= 1 - ( (1-z) + (z * gi/(gi+k*gj)))
        #This is one minus:
               #the sum of
                  # the probability of not engaging into social learning ... (1-z)
                  # the probability of copyng (z), but retaining the focal trait after evaluation ... gi/(gi+k*gj)
        
        #Probability Others  losing the trait
        OthersLoss = (1 - (z * gi/(gi+k*gj)) + c - ((z * gi/(gi+k*gj)) *c)) ^k

        #Alternative Version

        #  InnovatorLoss = z
        #  OthersLoss = (1 - z * gi/(gi+(k-1)*gj) + c - (z * gi/(gi+(k-1)*gj) *c) )^ k 

        
        return(InnovatorLoss*OthersLoss)
    }



    
