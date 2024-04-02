check_dup <- function(x){
  
  #x = sort(x)
  
  dup = x[duplicated(x)]
  xpos = which(x %in% dup)
  xdup = x[xpos]
  
  res = data.frame(xpos, xdup)
  res.sorted = res[order(res$xdup), ]
  
  return(out=list("res"=res, "res.sorted"=res.sorted))
}
