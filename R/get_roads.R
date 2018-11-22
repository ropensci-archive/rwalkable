#' Get the road network for a location
#'
#' @description
#'
#' This function takes a location specified by the user and returns a \code{SpatialLinesDataFrame} object which contains all walkable roads in and around the location.
#'
#' @param location A character string specifying the location of interest (e.g. "Melbourne Vic") or a matrix-like bounding box.
#' @param ... Extra arguments to the function \code{opq}.
#' @return An object of class SpatialLinesDataFrame
#'
#' @details
#'
#' A walkable road is defined as a road which (1) does not *not have sidewalks* and (2) is *not listed as a motorway or a motorway link* in OpenStreetMaps.
#'
#' @examples
#'
#' # For Melbourne, Victoria, Australia
#'
#' melbourne <- get_roads("melbourne vic")
get_roads <- function(location, ...){

  # Construct query
  query <- opq(location, ...) %>%
    add_osm_feature(key = "highway")

  # Check results
  not_good <- any(unlist(lapply(query, is.null)))
  if(not_good){
    stop("INTERNAL ERROR WITH QUERY, PLEASE CHECK LOCATION SUPPLIED.")
  }

  # Get data from query
  the_data <- osmdata_sp(query)$osm_lines

  # Cut out those lines with no sidewalks
  side_walk <- subset(
    the_data,
    sidewalk != "none" | is.na(sidewalk)
  )

  # Cut out those lines which are motorways / motorway links, which are by definition unwalkable
  walkables <- subset(
    side_walk,
    !highway %in% c("motorway", "motorway_link")
  )

  # Return this SpatialLinesDataFrame object
  return(walkables)

}
