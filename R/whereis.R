#' @param place a character vector of place names
#' @title Look up coordinates.
#' @description Look up latitude and longitude for a geographical place name
#' @export
#' @usage whereis(place, quietly=FALSE)
#' @examples 
#'   whereis("Melbourne")
#'   whereis("Onehunga, Auckland, New Zealand")
#'   whereis("Love, OK")
#' @param place name of the geographic place 
#' @param quietly if FALSE, throw an error on failure to find the place

whereis <-function(place, quietly=FALSE){
  bb<-osmdata::getbb(place)
  if(is.na(bb[1,1]) && !quietly)
    stop(paste("can't find",place,"on OpenStreetMap."))
  
  return(c(latitude=mean(bb["y",]),
              longitude=mean(bb["x",])))
}