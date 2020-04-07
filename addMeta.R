addMeta <- function(data) {
  
  out.df <- data.frame(
    Uniprot.Acc = NA,
    Gene = NA,
    Protein = NA,
    MW = NA,
    pI = NA,
    Unique.peptides = NA
  )
  
  for (cur.row in 1:nrow(data)) {
    
    pos.prot <- grep(data[cur.row, "protein"], fasta.header, fixed = TRUE)
    
    ## Extract Uniprot Acc.No.
    
    end.acc <- gregexpr("\\|", fasta.header[[pos.prot]])[[1]][2] - 1
    cur.acc <- substring(fasta.header[[pos.prot]], 5, end.acc)
    
    ## Extract Gene name
    
    cur.gene <- str_extract(fasta.header[[pos.prot]], "GN=.*? ")
    cur.gene <- substr(cur.gene, 4, nchar(cur.gene) - 1)
    
    ## Extract protein name
    
    start.prot <- regexpr(" ", fasta.header[[pos.prot]]) + 1
    end.prot <- regexpr(" OS=", fasta.header[[pos.prot]]) - 1
    
    cur.prot <- substring(fasta.header[[pos.prot]], start.prot, end.prot)
    
    ## Calculate MW and pI
    
    cur.mw <- round(pmw(fasta.sequence[[pos.prot]]), 0)
    cur.pi <- round(computePI(fasta.sequence[[pos.prot]]), 2)
  
    out.df[cur.row, "Uniprot.Acc"] <- cur.acc
    out.df[cur.row, "Gene"] <- cur.gene
    out.df[cur.row, "Protein"] <- cur.prot
    out.df[cur.row, "MW"] <- cur.mw
    out.df[cur.row, "pI"] <- cur.pi
    out.df[cur.row, "Unique.peptides"] <- data[cur.row, "peptide_unique_count"]
      
  }  
  
  return(out.df)
  
}
