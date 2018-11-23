#' Get buffered road network
#'
#' @description
#'
#' Get polygons representing the roads leading to the accessible amenities returned by \code{nearby()}
#'
#' @param nearby_obj An object of class \code{nearby}.
#' @param buffer_dist A buffer distance in decimal degrees. Defaults to 0.0002 (~20 metres).
#' @return An object of class sf containing polygonal features representing the parts of the road network that lead to accessible amenities.
get_roads_isochrone <- function(nearby_obj, buffer_dist = 0.0002){

  # Location

  location <- nearby_obj$location

  # Get location to trace road network from
  location_xy <-if(is.character(location)) {
    whereis(location)
  } else if (inherits(location,"POINT")){
    location<-as.numeric(location)
  } else if (inherits(location,"MULTIPOINT")){
    location<-colMeans(location)
  } else location

  # Get roads as dodgr graph
  road_net <- get_roads_graph(nearby_obj$bounding_box)

  # Find subset of these which are within walking distance of the specified location
  goto_mat_x <- rowMeans(cbind(road_net$to_lon, road_net$from_lon))
  goto_mat_y <- rowMeans(cbind(road_net$to_lat, road_net$from_lat))
  goto_mat <- cbind(goto_mat_x, goto_mat_y)
  colnames(goto_mat) <- c("x", "y")
  subs_ind <- is_nearby(goto_mat, location_xy, road_net, nearby_obj$radius)
  subs_ind <- subs_ind[1, ]

  # Subset road network
  geom_nums <- unique(road_net$geom_num[subs_ind])
  road_net <- road_net[which(road_net$geom_num %in% geom_nums), ]

  # Coerce to class sf
  road_sfc <- dodgr::dodgr_to_sfc(road_net)$geoms

  # Buffer by fixed distance of 0.0002 arc-degrees
  road_buf <- tryCatch(sf::st_buffer(road_sfc, buffer_dist), error = function(e) stop("Cannot buffer"))

  # Dissolve
  road_buf <- sf::st_union(road_buf)

  # Return
  return(road_buf)

}
