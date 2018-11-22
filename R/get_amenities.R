#' Retrieve amenities for a neighbourhood
#' 
#' 
#' @param bbox bounding box either four numeric values or a character string
#' as passed to [osmdata::opq()].
#' 
#' @param amenities a character vector representing amentities to add as
#' defined by [Open Street Map](https://wiki.openstreetmap.org/wiki/Key:amenity). 
#' If missing will default to 
#' 
#'     
#' 
get_amenities <- function(bbox, amenities = NULL) {
  
  query <- osmdata::opq(bbox)
  
  if (is.null(include)) {
    query %>% 
      add_osm_feature("amenity")
  }
    
}