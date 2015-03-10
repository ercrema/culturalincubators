
##### Check Missing Files ########
module unload compilers/intel/11.1/072
module unload mpi/qlogic/1.2.7/intel
module unload mkl/10.2.5/035
module load recommended/r

R

LIST<-system("ls",intern=TRUE)
LIST<-unlist(lapply(LIST,function(x){return(strsplit(x,split="res")[[1]][2])}))
LIST<-as.numeric(unlist(strsplit(LIST,split=".csv")))
EXPECTED<-1:10000
MISSING<-EXPECTED[which(!EXPECTED%in%LIST)]

print(length(MISSING))
cat(paste("NewArgs=c(",paste(MISSING,collapse=","),"); Args=NewArgs[Args]",sep=""))

