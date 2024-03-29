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
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/join_short_fnames.R")
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/wrong_full_fnames_db.R")
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
#                       checking all farmers' names 
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

# repeat several times line 50 until you see no more wrong names 1, 2, and 3
(cf <- check_fnames(fname = unique_fnames, db = wrong_fnames_db, wf)) 
sort(unique(cf$full_fnames$farmer_name))

unique_fnames <- check_fnames(fname = unique_fnames, db = wrong_fnames_db, wf)$full_fnames$fname0
unique_fnames <- sort(unique(unique_fnames))

# check if still there are some wrong farmers' names
sort(unique(cf$sorted_full_fnames$fname0))  
  
# fix dx$fname using check_fnames() function

cf1 <- check_fnames(fname = d1$fname, db = wrong_fnames_db, wf)
cf2 <- check_fnames(fname = d2$fname, db = wrong_fnames_db, wf)
cf3 <- check_fnames(fname = d3$fname, db = wrong_fnames_db, wf)
cf4 <- check_fnames(fname = d4$fname, db = wrong_fnames_db, wf)
cf5 <- check_fnames(fname = d5$fname, db = wrong_fnames_db, wf)
cf6 <- check_fnames(fname = d6$fname, db = wrong_fnames_db, wf)
cf7 <- check_fnames(fname = d7$fname, db = wrong_fnames_db, wf)

d1$fname <- cf1$full_fnames$fname0
d2$fname <- cf2$full_fnames$fname0
d3$fname <- cf3$full_fnames$fname0
d4$fname <- cf4$full_fnames$fname0
d5$fname <- cf5$full_fnames$fname0
d6$fname <- cf6$full_fnames$fname0
d7$fname <- cf7$full_fnames$fname0

# check if dx$fname is in unique_fnames
fnames_list <- list(d1$fname, d2$fname, d3$fname, d4$fname, d5$fname, d6$fname, d7$fname)

n1 <- length(unique_fnames)
n2 <- length(fnames_list)
mtx <- matrix(nrow = n1, ncol = n2)

for(i in 1:n1){
  for(j in 1:n2){
    count0 = fnames_list[[j]] %in% unique_fnames[i]
    mtx[i, j] = sum(count0)
  }
}

mtx <- as.data.frame(mtx)
rownames(mtx) <- unique_fnames
mtx[,8] <- apply(mtx[,1:7], 1, sum)
mtx[mtx$V1 == 0, ]
mtx[mtx$V8 == 1, ]
mtx[mtx$V8 == 2, ]

################################################################################
#                       select data per XLSX's sheet 
################################################################################

d1$name1 <- cf1$full_fnames$name1
d1$name2 <- cf1$full_fnames$name2
d1$lastname1 <- cf1$full_fnames$lastname1
d1$lastname2 <- cf1$full_fnames$lastname2
d1$farmer_name <- cf1$full_fnames$fname0
d1$fname <- cf1$full_fnames$farmer_name
d1$farmer_gender <- d1$farmer.gender





