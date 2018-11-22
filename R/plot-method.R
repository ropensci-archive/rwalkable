
#' @rdname plot.nearby
#' @method plot nearby 
#' @import leaflet
#' @export
plot.nearby <- function(x, y, ...) {
  if (!missing(y)) {
    stop("Not valid for plot...")
  }
  
  leaflet() %>% 
    addTiles() %>% 
    fitBounds(lng1 = x$bounding_box[1,1],
              lat1 = x$bounding_box[2,1],
              lng2 = x$bounding_box[1,2],
              lat2 = x$bounding_box[2,2]) %>% 
    addCircleMarkers(lng = x$amenities[["x"]],
                     lat = x$amenities[["y"]],
                     label = x$amenities[["type"]]
                     )
  
}
