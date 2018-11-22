#' Get the dodgr object for a road network
#'
#' @description
#'
#' This function takes a location and returns a graph object which contains the walkable roads in and around that location.
#'
#' @param location A character string specifying the location of interest (e.g. "Melbourne Vic") or a matrix-like bounding box.
#' @param ... Extra arguments to the function \code{dodgr_streetnet}.
#' @return An object of class igraph
#'
#' @examples
#'
#' \dontrun{
#' # For Melbourne
#'
#' get_roads_graph("melbourne vic")
#' }
get_roads_graph <- function(location, ...){

  # Check input
  if(is.character(location)){
    location <- getbb(location)
  }

  # Use dodgr
  roads_gph <- osmdata::opq(location) %>% osmdata::add_osm_feature(key = "highway") %>%
    osmdata::osmdata_sf(quiet = TRUE) %>% osmdata::osm_poly2line()

  # Return
  return(roads_gph$osm_lines)

}
