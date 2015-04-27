##############################################################################
# Title: Scripts for Experiment #1 for the paper: "Cultural Incubators and the Spread of Innovation", authored by E.Crema and M.Lake, submitted to Human Biology
# Requires R functions in the file src.R
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

#load library for faster parallel execution#
library(utils)
library(foreach)
library(doParallel)
registerDoParallel(cores=4)
source("./src.R")

# The scripts below conduct the functions CiB() and CB() nsim times, and compute the proprtion of runs where the innovator's trait was lost. 

# Without Convergent Innovation #
#Random Copying
baseline=RC(k=1:150,c=0,z=1)
#Copy if Better
nsim=10000 # set number of simulations
CiB.Avg3Sigma05=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0,gi=3,gj=1,sigma=0.5,z=1)))/nsim}
CiB.Avg3Sigma1=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0,gi=3,gj=1,sigma=1,z=1)))/nsim}
CiB.Avg3Sigma3=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0,gi=3,gj=1,sigma=3,z=1)))/nsim}
#Copy the Best
CB.Avg3Sigma05=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0,gi=3,gj=1,sigma=0.5,z=1)))/nsim}
CB.Avg3Sigma1=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0,gi=3,gj=1,sigma=1,z=1)))/nsim}
CB.Avg3Sigma3=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0,gi=3,gj=1,sigma=3,z=1)))/nsim}


# With Convergent Innovation #
#Random Copying
baseline.c=RC(k=1:150,c=0.005,z=1)
#Copy if Better
CiB.Avg3Sigma05.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0.005,gi=3,gj=1,sigma=0.5,z=1)))/nsim}
CiB.Avg3Sigma1.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0.005,gi=3,gj=1,sigma=1,z=1)))/nsim}
CiB.Avg3Sigma3.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CiB(k=k,c=0.005,gi=3,gj=1,sigma=3,z=1)))/nsim}
#Copy the Best
CB.Avg3Sigma05.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0.005,gi=3,gj=1,sigma=0.5,z=1)))/nsim}
CB.Avg3Sigma1.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0.005,gi=3,gj=1,sigma=1,z=1)))/nsim}
CB.Avg3Sigma3.c=foreach(k=1:150,.combine=c) %dopar% {sum(replicate(nsim,CB(k=k,c=0.005,gi=3,gj=1,sigma=3,z=1)))/nsim}

save.image("./experiment1/experiment1.RData")


