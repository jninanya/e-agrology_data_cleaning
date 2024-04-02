
# require "stringi" and "dplyr" library

check_fnames <- function(fnames, db, wf, na.rm = TRUE){
  
  # quick cleaning of farmer names
  fnames <- as.character(fnames)
  fnames <- tolower(fnames)
  fnames <- stri_trans_general(fnames, id = "Latin-ASCII")
  fnames <- gsub("\\s+", " ", fnames)
  
  # xx 
  name1 = vector()
  name2 = vector()
  lastname1 = vector()
  lastname2 = vector()
  farmer_name = vector()
  length_name = vector()
  
  bcfnames = vector()

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
        
        # identify wrong name/lastname
        i1 <- i1 + 1
        xpos1[i1] <- i
        wfnames1[i1] <- paste0(xname, collapse = " ")
        
        # 
        xx = xname[xname %in% db$wfnames]
        x0 = vector()
        
        for(ii in 1:length(xx)){
          
            x0 <- c(x0, db$cfnames[db$wfnames==xx[ii]])
        }
        
        xname[xname %in% db$wfnames] = x0
        cfnames1[i1] = paste0(xname, collapse = " ")
        
      }

      # CHECK ERROR 1
      # when the farmer name is on "wf" database
      joined_name = paste0(xname, collapse = " ")
      
      if(sum(joined_name %in% wf$wfname)==1){
        
        i2 = i2 + 1
        xpos2[i2] = i
        cfname = wf$cfname[wf$wfname==joined_name]
        xname = unlist(strsplit(cfname, "\\s+"))
        wfnames2[i2] = joined_name
        cfnames2[i2] = cfname
      }
      
      
      
      fname0[i] = paste0(xname, collapse = " ")
      
      if(n == 3){
        N1 = xname[1]
        N2 = NA
        L1 = xname[2]
        L2 = xname[3]
        FN = paste0(L1, " ", L2, ", ", N1)
        
      }else if(n == 4){
        
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
      
      fname0[i] = NA
      name1[i] = NA
      name2[i] = NA
      lastname1[i] = NA
      lastname2[i] = NA
      farmer_name[i] = NA
      length_name[i] = NA
      
      }

    }
    
  }
  
  sorted_fnames = data.frame("by_name" = sort(fname0), "by_lastname" = sort(farmer_name))
  full_fnames = data.frame(lastname1, lastname2, name2, name1, farmer_name, length_name, fname0)
  sorted_full_fnames = full_fnames[order(full_fnames$lastname1), ]
  wrong_fnames1 = data.frame(xpos, wrong_fname, corrected_fname)
  wrong_fnames2 = full_fnames[full_fnames$length_name != 3 & full_fnames$length_name != 4, c("farmer_name", "length_name")]
  wrong_fnames3 = data.frame(xpos3, wrong_fname3, corrected_fname3)
  
  xres = list(sorted_fnames, full_fnames, sorted_full_fnames, wrong_fnames1, wrong_fnames2, wrong_fnames3)
  names(xres) = c("sorted_fnames", "full_fnames", "sorted_full_fnames", "wrong_fnames1", "wrong_fnames2", "wrong_fnames3")
  
  return(xres)

}