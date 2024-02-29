
# require "stringi" and "dplyr" library

check_fnames <- function(fname, db){
  
  fname = as.character(fname)
  fname = tolower(fname)
  fname = stri_trans_general(fname, id = "Latin-ASCII")
  fname = gsub("\\s+", " ", fname)
  
  name1 = vector()
  name2 = vector()
  lastname1 = vector()
  lastname2 = vector()
  farmer_name = vector()
  length_name = vector()
  
  fname0 = vector()

  xpos = vector()
  wrong_fname = vector()
  corrected_fname = vector()
  i_wrong_fname = 0

  for(i in 1:length(fname)){
    
    x = fname[i]
    
    if(!(is.na(x))){
    # check if farmer name "i" is null or na
    if(is.null(x) || is.na(x)){
      warning(paste0("Please check row ", i))
      stop("Farmer name is NULL or NA")
    }
    
    x = join_short_fnames(x)
    xname = unlist(strsplit(x, "\\s+"))
    n = length(xname)
    
    # check if farmer name "i" is in wrong farmers' names database 
    if(sum(xname %in% db$wrong_name) >= 1){
      i_wrong_fname = i_wrong_fname + 1
      xpos[i_wrong_fname] = i
      wrong_fname[i_wrong_fname] = paste0(xname, collapse = " ")
      xx = xname[xname %in% db$wrong_name]
      x0 = vector()
      for(ix in 1:length(xx)){
        x0 <- c(x0, db$corrected_name[db$wrong_name==xx[ix]])
      }
      xname[xname %in% db$wrong_name] = x0
      corrected_fname[i_wrong_fname] = paste0(xname, collapse = " ")
    }
    
    fname0[i] = paste0(xname, collapse = " ")
 
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
  
  sorted_fnames = data.frame("by_name" = sort(fname0), "by_lastname" = sort(farmer_name))
  full_fnames = data.frame(lastname1, lastname2, name2, name1, farmer_name, length_name, fname0)
  sorted_full_fnames = full_fnames[order(full_fnames$lastname1), ]
  wrong_fnames1 = data.frame(xpos, wrong_fname, corrected_fname)
  wrong_fnames2 = full_fnames[full_fnames$length_name != 3 & full_fnames$length_name != 4, c("farmer_name", "length_name")]
  
  xres = list(sorted_fnames, full_fnames, sorted_full_fnames, wrong_fnames1, wrong_fnames2)
  names(xres) = c("sorted_fnames", "full_fnames", "sorted_full_fnames", "wrong_fnames1", "wrong_fnames2")
  
  return(xres)

}