## # # # # # # # # # # # # # # # # # # # # # # # #
##
## Project: Early Stage Ovarian Cancer Biomarkers
##
## Script name: 01_Comet_MS_search.R
##
## Purpose of script: Comet MS database search of .mgf files
##
## Author: Florian Weiland
##
## Date Created: 2020-04-06
##
## # # # # # # # # # # # # # # # # # # # # # # # #

## Comet search ----
## Uses comet.params placed into same directory as .exe,
## FASTA as stated in comet.params

system(
  paste(
    "comet.2019014.win64.exe",
    "./MGFs/IMP151014_MSV-II-005-01_FW_GD1_01_3119.mgf",
    "./MGFs/IMP151014_MSV-II-005-02_FW_GD2_01_3121.mgf",
    "./MGFs/IMP151014_MSV-II-005-03_FW_GD3_01_3123.mgf",
    "./MGFs/IMP151014_MSV-II-005-04_FW_GD4_01_3125.mgf",
    "./MGFs/IMP151014_MSV-II-005-05_FW_GD5_01_3127.mgf"
    )
)

## Copy output files into respective folders, delete in original directory ----

txt.files <- list.files(
  "./MGFs",
  pattern = ".txt$"
)

xml.files <- list.files(
  "./MGFs",
  pattern = ".xml$"
)


file.copy(
  paste0("./MGFs/", txt.files),
  paste0("./Data/", txt.files)
)

file.copy(
  paste0("./MGFs/", xml.files),
  paste0("./XMLs/", xml.files)
)

file.remove(paste0("./MGFs/", txt.files))
file.remove(paste0("./MGFs/", xml.files))
