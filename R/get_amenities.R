#' Retrieve amenities for a neighbourhood/location
#' 
#' 
#' @param location The bbox of the location as determined by `nearby()`.
#' 
#' @param amenities a character vector representing amentities to add as
#' defined by [Open Street Map](https://wiki.openstreetmap.org/wiki/Key:amenity). 
#' If NULL will default to all amenity tags. For valid amenity tags use
#' `osmdata::available_tags("amenity")`
#' 
#' @return an sf Simple Features Collection of points
#'         
#' @importFrom osmdata opq add_osm_feature
get_amenities <- function(location, amenities = NULL) {
  
  query <- opq(location)
  
  if (is.null(amenities)) {
    query <- query %>% 
      add_osm_feature("amenity")
  } else {
    # add_osm_feature is not vectorised in value, so we will loop over it
    for (i in seq_along(amenities)) {
      query <- query %>% add_osm_feature("amenity", amenities[[i]])
    }
  }
  
  points <- osmdata_sf(query)$osm_points
  
  out <- data.frame(osm_id = points$osm_id, 
                    type = points$amenity, 
                    do.call("rbind", points$geometry))
  colnames(out)[3:4] <- c("x", "y")
  
  out
  
}