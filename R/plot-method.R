#' Produce a map of nearby amenities
#' 
#' @method plot nearby 
#' 
#' @param x An object of class `nearby`
#' @param y  Not used for `plot.nearby`
#' @param overlay_isochrone Overlay an isochrone as polygons? Defaults to `TRUE`.
#' @param ... Additional arguments to plot, currently does not do anything
#' 
#' @details The plot method produces a map of nearby amenities, with
#' a isochrone over the amenities' longitude and latitude with the road network.
#' If `overlay_isochrone = FALSE`, then a convex hull over the amenties' longitude
#' and latitude. There is a dropdown menu on the top right, to filter by by an 
#' amenity type. 
#' 
#' @return a Leaflet map widget 
#' 
#' @examples
#' \dontrun{
#' plot(nearby("Carlton North, Victoria")) 
#' plot(nearby("Carlton North, Victoria", radius = walk_time(15))) 
#' }
#' 
#' @import leaflet
#' @export plot.nearby
plot.nearby <- function(x, y, overlay_isochrone = TRUE, ...) {
  if (!missing(y)) {
    stop("Not valid for plot.nearby...")
  }
  
  amenities <- stats::na.omit(x$amenities)

  if (overlay_isochrone) {
    poly <- suppressWarnings(get_roads_isochrone(x)) 
    map <- leaflet(poly) %>%
      addPolygons(opacity = 0.3, group = "isochrone")
  } else {
    hpts <- grDevices::chull(amenities[, c("x", "y")])
    map <-  leaflet() %>% 
      addPolygons(lng = amenities[hpts, "x"], 
                  lat = amenities[hpts, "y"],
                  opacity = 0.3,
                  group = "isochrone")
  }
  
  map <- map %>% 
    addTiles() %>% 
    fitBounds(lng1 = x$bounding_box[1,1],
              lat1 = x$bounding_box[2,1],
              lng2 = x$bounding_box[1,2],
              lat2 = x$bounding_box[2,2]) %>% 
    addCircleMarkers(lng = x$location_coords[2], lat = x$location_coords[1]) %>% 
    addCircles(lng = amenities[["x"]],
               lat = amenities[["y"]],
               group = amenities[["type"]],
               radius = 0.2,
               opacity = 0.8,
               color = "black") %>% 
    addLayersControl(
      baseGroups = c("isochrone", "none"),
      overlayGroups = unique(amenities[["type"]])
    )
  
  map
}
