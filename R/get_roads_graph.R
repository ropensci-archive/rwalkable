#' Get the sf object for a road network
#'
#' @description
#'
#' This function takes a location and returns an \code{sf} object which contains the walkable roads in and around that location.
#'
#' @param location A character string specifying the location of interest (e.g. "Melbourne Vic") or a matrix-like bounding box.
#' @return An object of class sf
#'
#' @examples
#'
#' \dontrun{
#' # For Melbourne
#'
#' get_roads_graph("melbourne vic")
#' }
get_roads_graph <- function(location){

  # Check input
  if(is.character(location)){
    location <- getbb(location)
  }

  # Use dodgr
  roads_gph <- osmdata::opq(location) %>% osmdata::add_osm_feature(key = "highway") %>%
    osmdata::osmdata_sf(quiet = TRUE) %>% osmdata::osm_poly2line()

  # Remove highways
  osm_lines <- roads_gph$osm_lines
  osm_lines <- tryCatch(subset(osm_lines, highway != "raceway"), error = function(e) osm_lines)

  # Return
  dodgr::weight_streetnet(osm_lines,
                          wt_profile = "foot")

}
