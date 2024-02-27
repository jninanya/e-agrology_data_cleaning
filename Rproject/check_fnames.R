
check_fnames <- function(fname){
  
  name1 = vector()
  name2 = vector()
  lastname1 = vector()
  lastname2 = vector()
  farmer_name = vector()
  length_name = vector()

  for(i in 1:length(fname)){
    
    x = fname[i]
    
    if(is.null(x) || is.na(x)){
      warning(paste0("Please check row ", i))
      stop("Farmer name is NULL or NA")
    }
    
    xname = unlist(strsplit(x, "\\s+"))
    n = length(xname)
    
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
  }
  
  full_list = data.frame(lastname1, lastname2, name2, name1, farmer_name, length_name)
  wrong_list = full_list[full_list$length_name != 3 & full_list$length_name != 4, c("farmer_name", "length_name")]
  
  xres = list(farmer_name, full_list, wrong_list)
  names(xres) = c("farmer_name", "full_list", "wrong_list")
  
  return(xres)

}