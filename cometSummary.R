cometSummary <- function(datafile, e.value, sig.pep){

  ## Read in data

  data <- read.csv(
    datafile,
    sep = "\t",
    skip = 1,
    row.names = NULL,
    stringsAsFactors = FALSE
  )
  
  ## Adjust colnames
  colnames(data)[1:18] <- colnames(data)[2:19]
  data <- data[, 1:18]
  
  ## Get significant peptides
  sig.pep.rows <- which(data$e.value <= e.value) 
  data.sig <- data[sig.pep.rows, ]
  
  ## Remove decoy hits
  
  dec <- grep("^DECOY", data.sig$protein)
  data.sig <- data.sig[-dec, ]
  
  ## Sum up proteins
  ## There may be several proteins per peptide, separated by comma
  
  uni.prot <- unique(data.sig$protein)
  uni.prot <-  unique(unlist(strsplit(uni.prot, ",")))
  
  data.pep <- data.frame()
  
  for (cur.prot in uni.prot) {
    
    pep.rows <- grep(cur.prot, data.sig$protein, fixed = TRUE)
    
    data.temp <- data.sig[pep.rows, ]
    data.temp$peptide_count <- length(pep.rows)
    data.temp$peptide_unique_to_protein <- ifelse(data.temp$protein_count > 1, "Not unique", "Unique")
    data.temp$peptide_unique_count <- length(which(data.temp$peptide_unique_to_protein == "Unique"))
    
    data.pep <- rbind(data.pep, data.temp)
    
  }
  
  ## At least two significant peptides
  
  data.pep <- data.pep[order(data.pep$peptide_unique_count, decreasing = TRUE), ]
  data.pep <- data.pep[data.pep$peptide_unique_count >= sig.pep, ]
  
  ## Only proteins with peptides unique to them
  
  data.prot <- data.pep[!duplicated(data.pep$protein), ]
  data.prot <- data.prot[data.prot$peptide_unique_to_protein == "Unique", ]
  data.prot <- data.prot[, c("protein", "peptide_unique_count")]
  
  return(data.prot)

}

