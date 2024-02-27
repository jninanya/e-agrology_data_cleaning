# database of wrong farmers' names

# wrong LASTNAMES
db1 <- data.frame()
db1[1, 1:2] <- c("ninanya", "ninanya")
db1[1, 1:2] <- c("brieno", "briceno")
db1[2, 1:2] <- c("briseno", "briceno")

# wrong NAMES
db2 <- data.frame() 
db2[1, 1:2] <- c("johann", "johan")
db2[2, 1:2] <- c("rositas", "rosa")
db2[3, 1:2] <- c("anna", "ana")

# rename colnames and sort data alphabetically 
colnames(db1) <- c("wrong_name", "corrected_name")
wrong_fnames_db1 <- db1[order(db1$corrected_name, decreasing = FALSE),]

colnames(db2) <- c("wrong_name", "corrected_name")
wrong_fnames_db2 <- db2[order(db2$corrected_name, decreasing = FALSE),]

wrong_fnames_db <- rbind(wrong_fnames_db1, wrong_fnames_db2)

save(wrong_fnames_db, file = "wrong_fnames_db.RData")






