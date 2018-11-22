#' @export
#' @param location where to compute walkability
#' @param radius walkable distance in meters 
#' @param amenities character vector of amenities to include
#'  (or with minus sign exclude) from calculation. The default
#'  is to include all of them
#' @title Is there stuff nearby?
#' @description Given a location, look up features within a walking distance of 'radius' to summarise walkability

nearby <- function(location, radius=1500, amenities=NULL){
  
  location_xy <-if(is.character(location)) whereis(location) else location
  delta_lat<-radius_to_latitude(radius)
  delta_long<-radius_to_longitude(radius, location_xy$latitude)
  
  location_bb<-with(location_xy, 
                    matrix(c(longitude-delta_long, longitude+delta_long,
                             latitude-delta_lat, latitude+delta_lat),
                           ncol=2, byrow=TRUE))
  colnames(location_bb)<-c("min","max")
  rownames(location_bb)<-c("x","y")
  
  amenities <- get_amenities(location_bb, amenities)
  
  road_graph<- get_road_graph(location_bb)
  
  road_distances <- get_shortest_paths(road_graph)
  
  connectivity <- get_graph_metrics(road_graph)
  
  ## we know how to do this now: 
  ##   the amenities are snapped to the graph
  nearby_amenities <- amenities[is_nearby(amenities, road_distances, road_graph)]
  
  pop_density<- get_population_density(location_xy) ## NA if not available
  
  rval<- list( location=location, bounding_box=bounding_box, sys.call(), amenities=nearby_amenities, 
               person_density=pop_density$persons, dwelling_density=pop_density$dwellings, 
               connectivity=connectivity)
  class(rval)<-"nearby"
  rval
}