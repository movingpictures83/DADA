#First must have dada2 and Bioconductor installed: https://benjjneb.github.io/dada2/dada-installation.html 
#Must also have phyloseq installed: http://joey711.github.io/phyloseq/install.html
dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

library(ShortRead)
library(dada2); 
packageVersion("dada2")


input <- function(inputfile) {
  pfix <<- prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

  parameters <- read.table(inputfile, as.is=T);
  rownames(parameters) <- parameters[,1]
  fastqpfx <<- paste(pfix, toString(parameters["FASTQ", 2]), sep="")
  errpfx <<- paste(pfix, toString(parameters["errors", 2]), sep="")
}

run <- function() {
	derep_forward <<- readRDS(paste(fastqpfx, "forward", "rds", sep="."))
	derep_reverse <<- readRDS(paste(fastqpfx, "reverse", "rds", sep="."))
	errF <<- readRDS(paste(errpfx, "forward", "rds", sep="."))
	errR <<- readRDS(paste(errpfx, "reverse", "rds", sep="."))
	dadaFs <<- dada(derep_forward, err=errF, multithread=TRUE)
	dadaRs <<- dada(derep_reverse, err=errR, multithread=TRUE)
}

output <- function(outputfile) {
i=1
#print(names(dadaFs))
for (fn in names(dadaFs)) {
   uniquesToFasta(dadaFs[[i]], paste(outputfile, fn, sep="."))
   i <- i+1
}
i=1
for (fn in names(dadaRs)) {
   uniquesToFasta(dadaRs[[i]], paste(outputfile, fn, sep="."))
   i <- i+1
}
   #print(str(dadaFs))
   #write.csv(dadaFs$denoised, paste(outputfile, "forward", "denoised", "csv",sep="."))
   #write.csv(dadaFs$clustering, paste(outputfile, "forward", "clustering", "csv",sep="."))
   #write.csv(dadaFs$sequence, paste(outputfile, "forward", "sequence", "csv",sep="."))
   #write.csv(dadaFs$quality, paste(outputfile, "forward", "quality", "csv",sep="."))
   #write.csv(dadaFs$map, paste(outputfile, "forward", "map", "csv",sep="."))
   #write.csv(dadaFs$birth_subs, paste(outputfile, "forward", "birth_subs", "csv",sep="."))
   #write.csv(dadaFs$trans, paste(outputfile, "forward", "trans", "csv",sep="."))
   #write.csv(dadaFs$err_in, paste(outputfile, "forward", "err_in", "csv",sep="."))
   #write.csv(dadaFs$err_out, paste(outputfile, "forward", "err_out", "csv",sep="."))
   
   saveRDS(dadaFs, paste(outputfile, "forward", "rds", sep="."))
   saveRDS(dadaRs, paste(outputfile, "reverse", "rds", sep="."))
}


