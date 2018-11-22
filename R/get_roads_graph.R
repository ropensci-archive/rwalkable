#' Get the sf object for a road network
#'
#' @description
#'
#' This function takes a location and returns an \code{sf} object which contains the walkable roads in and around that location.
#'
#' @param location A character string specifying the location of interest (e.g. "Melbourne Vic") or a matrix-like bounding box.
#' @return An object of class data.frame/dodgr_streetnet
#'
#' @examples
#'
#' \dontrun{
#' # For Moorooka, Brisbane, QLD
#'
#' get_roads_graph("moorooka, brisbane, qld")
#' }
get_roads_graph <- function(location){

  # Check input
  if(is.character(location)){
    location <- getbb(location)
  }

  # Get list of valid weight profiles for FOOT TRAVEL
  valid <- subset(dodgr::weighting_profiles, name == "foot")$way

  # Use dodgr
  roads_gph <- tryCatch(
    osmdata::opq(location) %>%
      osmdata::add_osm_feature(key = "highway") %>%
      osmdata::osmdata_sf(quiet = TRUE) %>%
      osmdata::osm_poly2line(),
    error = function(e){
      stop("Internal error. Please check location supplied.")
    }
  )

  # Remove highways
  osm_lines <- roads_gph$osm_lines
  osm_lines <- tryCatch(subset(osm_lines, highway %in% valid), error = function(e) osm_lines)

  # Return
  dodgr::weight_streetnet(osm_lines,
                          wt_profile = "foot")

}
