#' @export
#' @param location where to compute walkability
#' @param radius walkable distance in meters 
#' @param amenities character vector of amenities to include
#'  (or with minus sign exclude) from calculation. The default
#'  is to include all of them
#' @title 

nearby <- function(location, radius=1500, amenities=NULL){
  
  location <-standardise_location(location)
  delta_lat<-radius_to_latitude(radius)
  delta_long<-radius_to_longitude(radius, location$latitude)
  
  amenities <- get_amenities(location, delta_lat, delta_long, amenities)
  
  road_graph<- get_road_graph(location, radius)
  
}