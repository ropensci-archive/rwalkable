#' Get the igraph object for a road network
#'
#' @description
#'
#' This function takes a location and returns a graph object which contains the walkable roads in and around that location.
#'
#' @param location A character string specifying the location of interest (e.g. "Melbourne Vic") or a matrix-like bounding box.
#' @param ... Extra arguments to the function \code{opq}.
#' @return An object of class igraph
#'
#' @details
#'
#' A walkable road is defined as a road which (1) does not *not have sidewalks* and (2) is *not listed as a motorway or a motorway link* in OpenStreetMaps.
#'
#' @examples
#'
#' # For Melbourne
#'
#' get_roads_graph("melbourne vic")
get_roads_graph <- function(location, ...){

  # Get the sp object for the roads in the location
  roads_shp <- get_roads(location, ...)

  # Coerce to graph object
  roads_gph <- readshpnw(roads_shp, longlat = TRUE)

  # Return
  return(roads_gph)

}
