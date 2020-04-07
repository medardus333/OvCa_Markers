## # # # # # # # # # # # # # # # # # # # # # # # #
##
## Project: Early Stage Ovarian Cancer Biomarkers
##
## Script name: 00_Wrapper_MS_analysis.R
##
## Purpose of script: Wrapper script to analyse MS data
##
## Place all .mgf files in ./MGFs
## Place R functions cometSummary.R and addMeta.R in ./Functions
## Place comet.2019014.win64.exe and comet.params in ./
## Place 191203_Uniprot_human_isoforms.fasta in ./FASTA
##
## Comet is available from http://comet-ms.sourceforge.net/
## Release 2019.01 rev. 4 was used to compute data. 
##
## Author: Florian Weiland
##
## Date Created: 2020-04-06
##
## # # # # # # # # # # # # # # # # # # # # # # # #

## Check for required libraries and install if missing ----

# libs <- c(
#   "seqinr",
#   "stringr"
# )
# 
# libs.install <- which(libs %in% rownames(installed.packages()) == FALSE)
# 
# if (length(libs.install) >= 1) {
#   install.packages(libs[libs.install])
# }

## Directories

if (dir.exists("./Data/") == FALSE) {

dir.create("./Data/")

}

if (dir.exists("./XMLs/") == FALSE) {
  
  dir.create("./XMLs/")
  
}

if (dir.exists("./Output_R/") == FALSE) {

dir.create("./Output_R/")

}

## Source scripts

source("01_Comet_MS_search.R")
source("02_Comet_data_analysis.R")

