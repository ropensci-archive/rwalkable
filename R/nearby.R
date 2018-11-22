#' @export
#' @param location where to compute walkability
#' @param radius walkable distance in meters 
#' @param amenities character vector of amenities to include
#'  (or with minus sign exclude) from calculation. The default
#'  is to include all of them
#' @title Is there stuff nearby?
#' @description Given a location, look up features within a walking distance of 'radius' to summarise walkability
#' @examples 
#' \dontrun{
#' nearby("Onehunga, Auckland, New Zealand")
#' nearby("Springvale, Victoria, Australia")
#' nearby("Paris, France")
#' nearby("Paris, Texas")
#' nearby("3rd Arrondissement, Paris, France")
#' nearby("Onehunga, Auckland, New Zealand", radius=walk_time(10))
#' nearby(c(latitude=40.7316, longitude=-73.9863))
#' nearby(sf::st_point(c(40.7316,-73.9863)))
#' }

nearby <- function(location, radius=800, amenities=NULL){
  
  location_xy <-if(is.character(location)) {
    whereis(location) 
  } else if (inherits(location,"POINT")){
    l<-as.numeric(location)
    names(l)<-c("latitude","longitude")
    l
  } else if (inherits(location,"MULTIPOINT")){
    l<-colMeans(location)
    names(l)<-c("latitude","longitude")
    l
  } else location
    
  delta_lat<-radius_to_latitude(radius)
  delta_long<-radius_to_longitude(radius, location_xy["latitude"])
  
  location_bb<-  matrix(c(location_xy["longitude"]-delta_long, 
                          location_xy["longitude"]+delta_long,
                          location_xy["latitude"]-delta_lat, 
                          location_xy["latitude"]+delta_lat),
                           ncol=2, byrow=TRUE)
  colnames(location_bb)<-c("min","max")
  rownames(location_bb)<-c("x","y")
  
  amenities <- get_amenities(location_bb, amenities)
  
  road_graph <- get_roads_graph(location_bb)
  
  nearby_amenities <- amenities[is_nearby(to=amenities[,c("x","y")], 
                                          from=location_xy, 
                                          road_graph, radius),]
  
  connectivity <- get_graph_metrics(road_graph)
  
  rval<- list( location=location, bounding_box=location_bb, call=sys.call(), 
               amenities=nearby_amenities, radius=radius,
               connectivity=connectivity)
  class(rval)<-"nearby"
  rval
}

#' @export print.nearby

print.nearby<-function(x,...){
  if (is.numeric(x$location)) 
    location<-paste0("(",x$location["latitude"], ",", x$location["longitude"],")")
  else
    location<-x$location
  area<-pi*x$radius^2/10000
  cat("Within ", x$radius," m of", x$location,"\n")
  cat("  ", round(nrow(x$amenities)/area,1),"points of interest per hectare\n")
  cat("  ", round(x$connectivity/area,1),"intersections per hectare\n")
  invisible(x)
}

