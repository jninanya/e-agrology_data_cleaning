#
rm(list=ls())

# libraries
library(openxlsx)
library(dplyr)
library(stringi)

# load additional functions/scripts
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/check_farmer_names.R")

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
### checking farmer names 
################################################################################

d1$fname <- paste(d1$name, d1$last_name, d1$mother_last_name, sep = " ")
d2$fname <- d2$Productor
d3$fname <- d3$Productor
d4$fname <- d4$Productor
d5$fname <- d5$Productor
d6$fname <- d6$Productor
d7$fname <- d7$Productor

farmer_names <- tolower(c(d1$fname, d2$fname, d3$fname, d4$fname, d5$fname, d6$fname, d7$fname))
unique_farmer_names <- sort(unique(farmer_names))

unique_farmer_names <- check_fnames(unique_farmer_names)$fnames_checked
unique_farmer_names <- sort(unique(unique_farmer_names))
check_fnames(unique_farmer_names)


















