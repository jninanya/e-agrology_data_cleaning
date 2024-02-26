#
# require "stringi" library

check_fname <- function(x){
  
  x=as.character(x)
  x=tolower(x)
  x=stri_trans_general(x, id = "Latin-ASCII")
  x=gsub("\\s+", " ",x)
  
  # extracting wrong farmer names 
  xpos = which(x == "adelmo fernandez brieno"|
               x == "albertina contreras de la cruz"|
               x == "ananias pizan briceno "|
               x == "anna de la cruz cuevas"|
               x == "aresio villanueva pantoja"|
               x == "ariet ovita briseno caipo"|
               x == "aureliana vasquez de vargas"|
               x == "beber iraldo reyes baca"|
               x == "benigno\\t alvarado\\t gonzales"|
               x == "benigno\t alvarado\t gonzales"|
               x == "bennigno lazaro lara segura"|
               x == "bladimiro rodriguez malqui"|
               x == "carlos simeon\\t yupanqui\\t alva"|
               x == "carlos simeon\t yupanqui\t alva"|
               x == "carlos yupanqui alva"|
               x == "ch-488 ruiz briceno"|
               x == "cirio santos lara briceno"|
               x == "crestina vargas `pinedo"|
               x == "daniel lara rodrigues"|
               x == "dionicio rojas contreras"|
               x == "donatila de la cruz briceno"|
               x == "eduan mauricio mallqui"|
               x == "eias contreras infantes"|
               x == "ella leonor rios saldoval"|
               x == "elmer\\t villanueva reyes"|
               x == "elmer\t villanueva reyes"|
               x == "ermenegildo wigberto marquina cruz"|
               x == "ethelvil vazques marquina "|
               x == "eulogio videl valles"|
               x == "genaro gevara golszales"|
               x == "graciela esther robles de la cruz"|
               x == "gregorio carvajal medina"|
               x == "greogorio fernando rodriguez baca"|
               x == "hipolito marino rondo blaz"|
               x == "jaime carranza fabian "|
               x == "jose dolores segura revaza"|
               x == "juan robles sandoval"|
               x == "julio otiano lopez"|
               x == "julio zacarias ruiz polo"|
               x == "kelyn feliciita robles mauricio"|
               x == "liliar galarreta briceno "|
               x == "lucia de la cruz iparraguirre"|
               x == "lusila\\t reyes tamayo"|
               x == "lusila\t reyes tamayo"|
               x == "marciano\\t iparraguirre lopez"|
               x == "marciano\t iparraguirre lopez"|
               x == "marcine mayrita cabrera garsia"|
               x == "marcos briseno mauricio"|
               x == "marina araujo marquina "|
               x == "milagros\\t ruiz carranza"|
               x == "milagros\t ruiz carranza"|
               x == "milena de la cruz laiza"|
               x == "patrocinio\\t robles garcia"|
               x == "patrocinio\t robles garcia"|
               x == "presentaciona vasquez robles"|
               x == "rober iban aranda araujo "|
               x == "rositas laiza reyes"|
               x == "rositas layza reyes"|
               x == "santiago contreras de la cruz"|
               x == "santos meza rodriguez"|
               x == "santos martin meza rodriguez"|
               x == "vicente rodriguez\\t guzman"|
               x == "vicente rodriguez\t guzman"|
               x == "wilson lonardi villanueva morales"
  )
  
  wrong_names = data.frame("pos" = xpos, "fname" = x[xpos])
  
  # checking farmer names
  x[x == "adelmo fernandez brieno"] = "adelmo fernandez briceno"
  x[x == "albertina contreras de la cruz"] = "albertina contreras de_la_cruz"
  x[x == "ananias pizan briceno "] = "ananias pizan briceno"
  x[x == "anna de la cruz cuevas"] = "anna de_la_cruz cuevas"
  x[x == "aresio villanueva pantoja"] = "arensio villanueva pantoja"
  x[x == "ariet ovita briseno caipo"] = "ariet ovita briceno caipo"
  x[x == "aureliana vasquez de vargas"] = "aureliana vasquez de_vargas"
  x[x == "beber iraldo reyes baca"] = "beder iraldo reyes baca"
  x[x == "benigno\\t alvarado\\t gonzales" | x == "benigno\t alvarado\t gonzales"] = "benigno alvarado gonzales"
  x[x == "bennigno lazaro lara segura"] = "benigno lazaro lara segura"
  x[x == "bladimiro rodriguez malqui"] = "vladimiro rodriguez malqui"
  x[x == "carlos simeon\\t yupanqui\\t alva" | x == "carlos simeon\t yupanqui\t alva" | x == "carlos yupanqui alva"] = "carlos simeon yupanqui alva"
  x[x == "ch-488 ruiz briceno"] = "cornelio ruiz briceno"
  x[x == "cirio santos lara briceno"] = "cirilo santos lara briceno"
  x[x == "crestina vargas `pinedo"] = "crestina vargas pinedo"
  x[x == "daniel lara rodrigues"] = "daniel lara rodriguez"
  x[x == "dionicio rojas contreras"] = "dionisio rojas contreras"
  x[x == "donatila de la cruz briceno"] = "donatila de_la_cruz briceno"
  x[x == "eduan mauricio mallqui"] = "eduar mauricio mallqui"
  x[x == "eias contreras infantes"] = "elias contreras infantes"
  x[x == "ella leonor rios saldoval"] = "elsa leonor rios saldoval"
  x[x == "elmer\\t villanueva reyes" | x == "elmer\t villanueva reyes"] = "elmer villanueva reyes"
  x[x == "ermenegildo wigberto marquina cruz"] = "ermenegildo wilberto marquina cruz"
  x[x == "ethelvil vazques marquina "] = "ethelvil vazques marquina"
  x[x == "eulogio videl valles"] = "eulogio vidal valles"
  x[x == "genaro gevara golszales"] = "genaro guevara gonzales"
  x[x == "graciela esther robles de la cruz"] = "graciela esther robles de_la_cruz"
  x[x == "gregorio carvajal medina"] = "gregorio carbajal medina"
  x[x == "greogorio fernando rodriguez baca"] = "gregorio fernando rodriguez baca"
  x[x == "hipolito marino rondo blaz"] = "hipolito marino rondo blas"
  x[x == "jaime carranza fabian "] = "jaime carranza fabian"
  x[x == "jose dolores segura revaza"] = "jose dolores segura rebaza"
  x[x == "juan robles sandoval"] = "juan robles sandobal"
  x[x == "julio otiano lopez"] = "julio otiniano lopez"
  x[x == "julio zacarias ruiz polo"] = "julio sacarias ruiz polo"
  x[x == "kelyn feliciita robles mauricio"] = "kelyn felicita robles mauricio"
  x[x == "liliar galarreta briceno "] = "liliar galarreta briceno"
  x[x == "lucia de la cruz iparraguirre"] = "lucia de_la_cruz iparraguirre"
  x[x == "lusila\\t reyes tamayo" | x == "lusila\t reyes tamayo"] = "lusila reyes tamayo"
  x[x == "marciano\\t iparraguirre lopez" | x == "marciano\t iparraguirre lopez"] = "marciano iparraguirre lopez"
  x[x == "marcine mayrita cabrera garsia"] = "marcine mayrita cabrera garcia"
  x[x == "marcos briseno mauricio"] = "marcos briceno mauricio"
  x[x == "marina araujo marquina "] = "marina araujo marquina"
  x[x == "milagros\\t ruiz carranza" | x == "milagros\t ruiz carranza"] = "milagros ruiz carranza"
  x[x == "milena de la cruz laiza"] = "milena de_la_cruz laiza"
  x[x == "patrocinio\\t robles garcia" | x == "patrocinio\t robles garcia"] = "patrocinio robles garcia"
  x[x == "presentaciona vasquez robles"] = "presentacion vasquez robles"
  x[x == "rober iban aranda araujo "] = "rober iban aranda araujo"
  x[x == "rositas laiza reyes" | x == "rositas layza reyes"] = "rosita layza reyes"
  x[x == "santiago contreras de la cruz"] = "santiago contreras de_la_cruz"
  x[x == "santos martin meza rodriguez" | x == "santos meza rodriguez"] = "santos martin mesa rodriguez"
  x[x == "vicente rodriguez\\t guzman" | x == "vicente rodriguez\t guzman"] = "vicente rodriguez guzman"
  x[x == "wilson lonardi villanueva morales"] = "wilson leonardo villanueva morales"
  
  wrong_names$corrected_names = x[xpos]
  xres = list("fnames_checked" = x,"wrong_names" = wrong_names)
  
  return(xres)
  
}
