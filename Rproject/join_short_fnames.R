join_short_fnames <- function(x){
  
  x = unlist(strsplit(x, "\\s+"))
  n = length(x)
  
  # Identify the position of short strings and separate them into groups
  y1 = which(nchar(x) < 3)
  y2 = split(y1, cumsum(c(1, diff(y1) != 1)))
  
  # join short strings
  IF = vector()
  minIF = vector()
  fName = vector()
  for(i in 1:length(y2)){
    ii = c(y2[[i]], max(y2[[i]])+1)
    ii = ii[ii <= n]
    IF = c(IF, ii)
    minIF[i] = min(ii)
    fName[i] = paste0(x[ii], collapse = "_")
  }
  
  # rewrite the name by replacing short strings with those that were joined
  k = 0
  nn = vector()
  IF1 = IF[!(IF %in% minIF)]
  IF2 = minIF
    
  for(i in 1:length(x)){
    if(!(i %in% IF1)){
      k = k + 1 
      if(i %in% IF2){
        nn[k] = fName[IF2 == i] 
      }else{
        nn[k] = x[i] 
      }
    }
  }
  
  xres = paste0(nn, collapse = " ")
  
  return(xres)
  
}
