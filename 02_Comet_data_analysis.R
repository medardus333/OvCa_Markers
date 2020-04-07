## # # # # # # # # # # # # # # # # # # # # # # # #
##
## Project: Early Stage Ovarian Cancer Biomarkers
##
## Script name: 02_Comet_data_analysis.R
##
## Purpose of script: Summarize comet output, attach protein metadata
##
## Author: Florian Weiland
##
## Date Created: 2020-04-06
##
## # # # # # # # # # # # # # # # # # # # # # # # #

## Libraries ----

library(seqinr)
library(stringr)

## Functions ----

source("./Functions/cometSummary.R")
source("./Functions/addMeta.R")

## Analyse comet .txt output files and summarize proteins ----

spot.736  <- cometSummary("./Data/IMP151014_MSV-II-005-01_FW_GD1_01_3119.txt", 0.05, 2)
spot.1252 <- cometSummary("./Data/IMP151014_MSV-II-005-02_FW_GD2_01_3121.txt", 0.05, 2)
spot.1295 <- cometSummary("./Data/IMP151014_MSV-II-005-03_FW_GD3_01_3123.txt", 0.05, 2)
spot.1507 <- cometSummary("./Data/IMP151014_MSV-II-005-04_FW_GD4_01_3125.txt", 0.05, 2)
spot.1930 <- cometSummary("./Data/IMP151014_MSV-II-005-05_FW_GD5_01_3127.txt", 0.05, 2)

## Protein Metadata ----
## Read and prepare FASTA for addMeta function

fasta <- read.fasta(
  "./FASTA/191203_Uniprot_human_isoforms.fasta",
  seqtype = "AA"
)

fasta.header   <- getAnnot(fasta)
fasta.sequence <- getSequence(fasta)
fasta.proteins <- getName(fasta)

## Add metadata

spot.736.df  <- addMeta(spot.736)
spot.1252.df <- addMeta(spot.1252)
spot.1295.df <- addMeta(spot.1295)
spot.1507.df <- addMeta(spot.1507)
spot.1930.df <- addMeta(spot.1930)

## Write data ----

write.csv(
  spot.736.df,
  "./Output_R/Spot736.csv",
  row.names = FALSE
)

write.csv(
  spot.1252.df,
  "./Output_R/Spot1252.csv",
  row.names = FALSE
)

write.csv(
  spot.1295.df,
  "./Output_R/Spot1295.csv",
  row.names = FALSE
)

write.csv(
  spot.1507.df,
  "./Output_R/Spot1507.csv",
  row.names = FALSE
)

write.csv(
  spot.1930.df,
  "./Output_R/Spot1930.csv",
  row.names = FALSE
)


