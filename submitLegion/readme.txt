;-*-Org-*-


* STEP 1: Data Preparation (./submitLegion/prepareSweep.R)

First the parameter space needs to be defined. This is achievied by
executing the the prepareSweep function, which generates a data.frame
with model parameters using Latin Hyper Cube Sampling. 

* STEP 2: Submit job
* STEP 3: Concatenate results from Terminal
#e.g.:
awk 'FNR > 1' res*.csv > combinedResultsModel1.csv
awk 'FNR > 1' res*.csv > combinedResultsModel2.csv
