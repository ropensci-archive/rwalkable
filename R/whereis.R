#' @param place a character vector of place names
#' @title Look up coordinates.
#' @description Look up latitude and longitude
#' @export
#' @examples 
#'   whereis("Melbourne")
#'   whereis("Onehunga, Auckland, New Zealand")
#'   whereis("Love, OK")

whereis <-function(place, quietly=FALSE){
  bb<-osmdata::getbb(place)
  if(is.na(bb[1,1]) && !quietly)
    stop(paste("can't find",place,"on OpenStreetMap."))
  
  return(list(latitude=mean(bb["y",]),
              longitude=mean(bb["x",])))
}