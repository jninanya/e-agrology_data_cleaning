#
rm(list=ls())

# libraries
library(openxlsx)
library(dplyr)

# read data

xlsx = "Bitacora agronomica-Peru_MEAL_04 de enero 2024.xlsx"

d1 <- read.xlsx(xlsx, sheet = 1, startRow = 2)
d2 <- read.xlsx(xlsx, sheet = 2)
d3 <- read.xlsx(xlsx, sheet = 3)
d4 <- read.xlsx(xlsx, sheet = 4)
d5 <- read.xlsx(xlsx, sheet = 5)
d6 <- read.xlsx(xlsx, sheet = 6)
d7 <- read.xlsx(xlsx, sheet = 7)

################################################################################
### 01 - Farmers-crop-site 
################################################################################
























