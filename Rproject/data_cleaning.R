################################################################################
#                         e-AGROLOGY DATA CLEANING 
################################################################################

rm(list=ls())

# libraries
library(openxlsx)
library(dplyr)
library(stringi)

# load additional functions/scripts/data
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/check_fnames.R")
load(url("https://github.com/jninanya/e-agrology_data_cleaning/raw/main/Rproject/wrong_fnames_db.RData"))

# read data from github
github_url_xlsx <- "https://github.com/jninanya/e-agrology_data_cleaning/raw/main/raw_data/Bitacora%20agronomica-Peru_MEAL_04%20de%20enero%202024.xlsx"

d1 <- read.xlsx(github_url_xlsx, sheet = 1, startRow = 2)
d2 <- read.xlsx(github_url_xlsx, sheet = 2)
d3 <- read.xlsx(github_url_xlsx, sheet = 3)
d4 <- read.xlsx(github_url_xlsx, sheet = 4)
d5 <- read.xlsx(github_url_xlsx, sheet = 5)
d6 <- read.xlsx(github_url_xlsx, sheet = 6)
d7 <- read.xlsx(github_url_xlsx, sheet = 7)


################################################################################
#                         checking farmers' names 
################################################################################

d1$fname <- paste(d1$name, d1$last_name, d1$mother_last_name, sep = " ")
d2$fname <- d2$Productor
d3$fname <- d3$Productor
d4$fname <- d4$Productor
d5$fname <- d5$Productor
d6$fname <- d6$Productor
d7$fname <- d7$Productor

# quick check of farmers' names
fnames <- tolower(c(d1$fname, d2$fname, d3$fname, d4$fname, d5$fname, d6$fname, d7$fname))
(unique_fnames <- sort(unique(fnames)))

# repeat several times "check_fnames(fname = unique_fnames, db = wrong_fnames_db)" until you see no more wrong names 1 and 2
# $wrong_fnames1
# [1] xpos            wrong_fname     corrected_fname
# <0 rows> (or 0-length row.names)
# 
# $wrong_fnames2
# [1] farmer_name length_name
# <0 rows> (or 0-length row.names)
(cf <- check_fnames(fname = unique_fnames, db = wrong_fnames_db)) 
unique_fnames <- check_fnames(fname = unique_fnames, db = wrong_fnames_db)$full_fnames$fname0

# check if still there are some wrong farmers' names
unique(sort(cf$sorted_full_fnames$farmer_name))  
  
















