#' @export
#' @param location where to compute walkability
#' @param radius walkable distance in meters 
#' @param amenities character vector of amenities to include
#'  (or with minus sign exclude) from calculation. The default
#'  is to include all of them
#' @title Is there stuff nearby?
#' @description Given a location, look up features within a walking distance of 'radius' to summarise walkability

nearby <- function(location, radius=800, amenities=NULL){
  
  location_xy <-if(is.character(location)) {
    whereis(location) 
  } else if (inherits(location,"POINT")){
    location<-as.numeric(location)
  } else if (inherits(location,"MULTIPOINT")){
    location<-colMeans(location)
  } else location
    
  delta_lat<-radius_to_latitude(radius)
  delta_long<-radius_to_longitude(radius, location_xy$latitude)
  
  location_bb<-with(location_xy, 
                    matrix(c(longitude-delta_long, longitude+delta_long,
                             latitude-delta_lat, latitude+delta_lat),
                           ncol=2, byrow=TRUE))
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
  if (is.list(x$location)) 
    location<-paste0("(",location$latitude, ",", location$longitude,")")
  else
    location<-x$location
  area<-pi*x$radius^2/10000
  cat("Within ", x$radius," m of", x$location,"\n")
  cat("  ", round(nrow(x$amenities)/area,1),"points of interest per hectare\n")
  cat("  ", round(x$connectivity/area,1),"intersections per hectare\n")
  invisible(x)
}

