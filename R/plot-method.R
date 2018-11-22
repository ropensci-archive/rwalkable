#' Produce a map of nearby amenities
#' 
#' @method plot nearby 
#' 
#' @param x An object of class `nearby`
#' @param y  Not used for `plot.nearby`
#' @param ... Additional arguments to plot, currently does not do anything
#' 
#' @details The plot method produces a map of nearby amenities, with
#' a convex hull over the amenities' longitude and latitude. There is
#' a dropdown menu on the top right, to filter by by an amenity type. 
#' 
#' 
#' @return a Leaflet map widget 
#' 
#' @import leaflet
#' @export
plot.nearby <- function(x, y, ...) {
  if (!missing(y)) {
    stop("Not valid for plot.nearby...")
  }
  
  hpts <- grDevices::chull(x$amenities[, c("x", "y")])
  
  leaflet() %>% 
    addTiles() %>% 
    fitBounds(lng1 = x$bounding_box[1,1],
              lat1 = x$bounding_box[2,1],
              lng2 = x$bounding_box[1,2],
              lat2 = x$bounding_box[2,2]) %>% 
    addCircles(lng = x$amenities[["x"]],
               lat = x$amenities[["y"]],
               group = x$amenities[["type"]],
               radius = 0.2,
               opacity = 0.5,
               color = "black"
               
    ) %>% 
    addPolygons(lng = x$amenities[hpts, "x"],
                lat = x$amenities[hpts, "y"]
                ) %>% 
    addLayersControl(overlayGroups = unique(x$amenities[["type"]]))
  
}
