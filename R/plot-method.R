#' @method plot nearby 
#' @import leaflet
#' @export
plot.nearby <- function(x, y, ...) {
  if (!missing(y)) {
    stop("Not valid for plot...")
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
