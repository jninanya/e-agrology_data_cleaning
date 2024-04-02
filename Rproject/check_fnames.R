
# require "stringi" and "dplyr" library

check_fnames <- function(fnames, db, wf, na.rm = TRUE){
  
  # quick cleaning of farmer names
  fnames <- as.character(fnames)
  fnames <- tolower(fnames)
  fnames <- stri_trans_general(fnames, id = "Latin-ASCII")
  fnames <- gsub("\\s+", " ", fnames)
  
  # output vectors
  name1 = vector()
  name2 = vector()
  lastname1 = vector()
  lastname2 = vector()
  farmer_name = vector()
  length_name = vector()
  
  cfname = vector()

  # define variables for error 1
  i1 <- 0
  xpos1 <- vector()
  wfnames1 <- vector()
  cfnames1 <- vector()
 
  # define variables for error 2
  i2 <- 0 
  xpos2 <- vector()
  wfnames2 <- vector()
  cfnames2 <- vector()

  # check farmer names individually (one by one)
  for(i in 1:length(fnames)){
    
    x <- fnames[i]
    na.fnames <- is.null(x) || is.na(x)
    
    # COND1: FARMER NAMES IS NOT NA
    if(!na.fnames){
      
      # check short farmer names/lastnames and separate them individually
      x <- join_short_fnames(x)
      xname <- unlist(strsplit(x, "\\s+"))
      n <- length(xname)
      
      # CHECK ERROR 1
      # when name or lastname is on "db" database
      if(sum(xname %in% db$wfnames) >= 1){
        
        # identify position of the wrong farmer name
        i1 <- i1 + 1
        xpos1[i1] <- i
        wfnames1[i1] <- paste0(xname, collapse = " ")
        
        # identify which name and/or lastname is wrong 
        w_list <- xname[xname %in% db$wfnames]
        c_list <- vector()
        
        # correct wrong names/lastnames previously identified
        for(ii in 1:length(w_list)){
          
          c_list <- c(c_list, db$cfnames[db$wfnames == w_list[ii]])
          
        }
        
        # replace wrong names/lastnames by corrected ones
        xname[xname %in% db$wfnames] = c_list
        cfnames1[i1] = paste0(xname, collapse = " ")
        
      }
      
      #xname <- xname

      # CHECK ERROR 2
      # when the farmer name is on "wf" database
      joined_fname = paste0(xname, collapse = " ")
      
      if(sum(joined_fname %in% wf$wfnames) == 1){
        
        # identify position of the wrong farmer name
        i2 = i2 + 1
        xpos2[i2] = i
        wfnames2[i2] = joined_fname
        
        # replace the wrong fname by the corrected one
        c_fname = wf$cfnames[wf$wfnames == joined_fname]
        cfnames2[i2] = c_fname
        xname = unlist(strsplit(c_fname, "\\s+"))
      }
      
      # final corrected farmer name 
      cfname[i] = paste0(xname, collapse = " ")
      
      if(n == 3){
        N1 = xname[1]
        N2 = NA
        L1 = xname[2]
        L2 = xname[3]
        FN = paste0(L1, " ", L2, ", ", N1)
        
      } else if(n == 4){
        
        N1 = xname[1]
        N2 = xname[2]
        L1 = xname[3]
        L2 = xname[4]
        FN = paste0(L1, " ", L2, ", ", N1, " ", N2)
        
      } else {
        
        N1 = NA
        N2 = NA
        L1 = NA
        L2 = NA
        FN = x
        
      }
      
      name1[i] = N1
      name2[i] = N2
      lastname1[i] = L1
      lastname2[i] = L2
      farmer_name[i] = FN
      length_name[i] = n
      
    # COND2: FARMER NAMES IS NA
    } else {
      
      # 
      if(!na.rm){

      warning(paste0("Please check row ", i))
      stop("Farmer name is NULL or NA")

      } else {
      
      cfname[i] = NA
      name1[i] = NA
      name2[i] = NA
      lastname1[i] = NA
      lastname2[i] = NA
      farmer_name[i] = NA
      length_name[i] = NA
      
      }

    }
    
  }
  
  out <- data.frame(lastname1, lastname2, name2, name1, farmer_name, length_name, cfname)
  err1 <- data.frame("xpos" = xpos1, "wfname" = wfnames1, "cfname" = cfnames1)
  err2 <- data.frame("xpos" = xpos2, "wfname" = wfnames2, "cfname" = cfnames2)
  err3 <- out[!(out$length_name >= 3 & out$length_name <= 4), c("cfname", "farmer_name", "length_name")]
  
  xres = list(out, err1, err2, err3)
  names(xres) = c("out", "err1", "err2", "err3")
  
  return(xres)

}