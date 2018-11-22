#' Retrieve amenities for a neighbourhood
#' 
#' 
#' @param location A character string or bounding box as passed to [osmdata::opq()].
#' 
#' @param ... additional arguments to pass to [osmdata::opq()].
#' 
#' @param amenities a character vector representing amentities to add as
#' defined by [Open Street Map](https://wiki.openstreetmap.org/wiki/Key:amenity). 
#' If NULL will default to all amenity tags. 
#' 
#' @return an sf Simple Features Collection of points
#'         
#' @importFrom osmdata opq add_osm_feature
get_amenities <- function(location, ..., amenities = NULL) {
  
  query <- opq(location, ...)
  
  if (is.null(amenities)) {
    query <- query %>% 
      add_osm_feature("amenity")
  } else {
    # add_osm_feature is not vectorised in value, so we will loop over it
    for (i in seq_along(amenities)) {
      query <- query %>% add_osm_feature("amenity", amenities[[i]])
    }
  }
  
  osmdata_sf(query)$osm_points
}