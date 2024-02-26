#
rm(list=ls())

# libraries
library(openxlsx)
library(dplyr)
library(stringi)

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
### 01 - Farmers-crop-site 
################################################################################

d1$name <- tolower(d1$name)
d1$name <- stri_trans_general(d1$name, id="Latin-ASCII")





















