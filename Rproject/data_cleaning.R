################################################################################
#                         e-AGROLOGY DATA CLEANING 
################################################################################
#
# Step 1 (S1): 
# Step 2 (S2):

rm(list=ls())

# libraries
library(openxlsx)
library(dplyr)
library(stringi)

# Load additional functions/scripts/data
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/check_fnames.R")
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/check_dup.R")
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/join_short_fnames.R")
source("https://raw.githubusercontent.com/jninanya/e-agrology_data_cleaning/main/Rproject/wrong_full_fnames_db.R")
load(url("https://github.com/jninanya/e-agrology_data_cleaning/raw/main/Rproject/wrong_fnames_db.RData"))

# Read data (each e-Agrology module) from github
github_url_xlsx <- "https://github.com/jninanya/e-agrology_data_cleaning/raw/main/raw_data/Bitacora%20agronomica-Peru_MEAL_04%20de%20enero%202024.xlsx"

d1 <- read.xlsx(github_url_xlsx, sheet = 1, startRow = 2)   # 1. Farmers module
d2 <- read.xlsx(github_url_xlsx, sheet = 3)                 # 2. Sowing module
d3 <- read.xlsx(github_url_xlsx, sheet = 2)                 # 3. Visits module
d4 <- read.xlsx(github_url_xlsx, sheet = 4)                 # 4. Harvest-1st module
d5 <- read.xlsx(github_url_xlsx, sheet = 5)                 # 5. Harvest-2nd module
d6 <- read.xlsx(github_url_xlsx, sheet = 6)                 # 6. Crop module
d7 <- read.xlsx(github_url_xlsx, sheet = 7)                 # 7. Productivity module


#-------------------------------------------------------------------------------
#                         S1. CHECK ALL FARMER NAMES 
#-------------------------------------------------------------------------------

# MERGE FARMER NAMES OF EACH MODULE
# Add column of farmer names
d1$fname <- paste(d1$name, d1$last_name, d1$mother_last_name, sep = " ")
d2$fname <- d2$Productor
d3$fname <- d3$Productor
d4$fname <- d4$Productor
d5$fname <- d5$Productor
d6$fname <- d6$Productor
d7$fname <- d7$Productor

# Merge and get unique values of farmer names
fnames <- tolower(c(d1$fname, d2$fname, d3$fname, d4$fname, d5$fname, d6$fname, d7$fname))
unique_fnames <- sort(unique(fnames))   
# NOTE: At this point, "unique_fnames" probably has wrong names that could be 
#       duplicates of others, so it has carefully been checked below

# QUICK CHECK OF FARMER NAMES
# Check wrong and duplicates names in "unique_fnames"
cf <- check_fnames(fnames = unique_fnames, db = wrong_fnames_db, wf = wf, na.rm = TRUE)
cf$err1   # 
cf$err2   # 
cf$err3   # 
sort(unique(cf$out$farmer_name))
# NOTE: This part is "manually" recursive in the following way:
#       1. Run "cf <- check_fnames(...)"
#       2. See in console the detected errors: cf$err1, cf$err2, and cf$err3
#       3. See in console "sort(unique(cf$out$farmer_name))" and identify 
#          visually others wrong farmer names still not detected
#       4. If some wrong farmer names are detected, add them manually in database
#          "wrong_fnames_db.RData" editing "create_wrong_fnames_db.R"
#       5. Repeat 1 to 4 until you do not see any error message in "cf$err1-3"

# Final list of unique farmer names
unique_fnames <- cf$out$cfname
unique_fnames <- sort(unique(unique_fnames))

# CORRECT FARMER NAMES FOR EACH e-AGROLOGY MODULE
cf1 <- check_fnames(fnames = d1$fname, db = wrong_fnames_db, wf)
cf2 <- check_fnames(fnames = d2$fname, db = wrong_fnames_db, wf)
cf3 <- check_fnames(fnames = d3$fname, db = wrong_fnames_db, wf)
cf4 <- check_fnames(fnames = d4$fname, db = wrong_fnames_db, wf)
cf5 <- check_fnames(fnames = d5$fname, db = wrong_fnames_db, wf)
cf6 <- check_fnames(fnames = d6$fname, db = wrong_fnames_db, wf)
cf7 <- check_fnames(fnames = d7$fname, db = wrong_fnames_db, wf)

d1$fname <- cf1$out$cfname
d2$fname <- cf2$out$cfname
d3$fname <- cf3$out$cfname
d4$fname <- cf4$out$cfname
d5$fname <- cf5$out$cfname
d6$fname <- cf6$out$cfname
d7$fname <- cf7$out$cfname

# CHECK IF FARMER NAMES OF EACH e-AGROLOGY MODULE IS IN "unique_fnames" 
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
#                        select data per XLSX's sheet 
################################################################################

#d1$name1 <- cf1$full_fnames$name1
#d1$name2 <- cf1$full_fnames$name2
#d1$lastname1 <- cf1$full_fnames$lastname1
#d1$lastname2 <- cf1$full_fnames$lastname2
#d1$farmer_name <- cf1$full_fnames$fname0
#d1$fname <- cf1$full_fnames$farmer_name

d1$farmer_name <- cf1$full_fnames$farmer_name
d1$plotID <- d1$Nombre.de.la.Parcela
d1$ID <- paste0(d1$farmer_name, " + ", d1$plotID)

dup1 <- check_dup(d1$farmer_name)
d1[dup1$res.sorted$xpos, c("farmer_name", "plotID")]



d1$farmer_gender <- d1$farmer.gender
d1$date_birth <- convertToDate(d1$date_birt)
d1$education_level <- d1$level_education
d1$cell_phone <- d1$cell.phone
d1$experience <- d1$experience
d1$organization <- d1$Organization
d1$departament <- d1$Departamento
d1$province <- d1$Province
d1$locality <- d1$Direccion
d1$plot_area <- d1$Superficie.Total.de.la.parcela
d1$type_property <- d1$type_property
d1$possesion_land <- d1$possesion_land
d1$coordinates <- d1$coordenadas
d1$record_date <- d1$Fecha_creación.de.la.bitacora
d1$season <- d1$`cycle/year`
d1$water_regime <- d1$water_regime
d1$production_type <- d1$production.type












