#wrong full fnames

wf = data.frame() 
wf[1, 1:2] <- c("alexander campos mesa", "alexander royer campos mesa")
wf[2, 1:2] <- c("carlos yupanqui alva", "carlos simeon yupanqui alva")
wf[3, 1:2] <- c("santos mesa rodriguez", "santos josefa mesa rodriguez")

colnames(wf) <- c("wfname", "cfname")
