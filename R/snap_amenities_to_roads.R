#' Snap amenities and other point-like features to the nearest vertex of walkable road features
#'
#' @description
#'
#' This function takes roads and amenities and ensures all amenities are treated as though they lie on the nearest road segment.
#'
#' @param roads A \code{SpatialLinesDataFrame} object containing the walkable roads within an area.
#' @param amenities An \code{sf} object containing the amenities within an area.
#' @return
snap_to_nearest <- function(roads, amenities){

  roads <- as(roads, "Spatial")
  roads <- as(roads, "SpatialPointsDataFrame")
  roads <- as(roads, "sf")

  # Identify the line vertices nearest to these
  n_amen <- nrow(amenities)
  for(i in 1:n_amen){
NULL
  }

}
