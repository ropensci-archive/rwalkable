#' @export
#' @param minutes time spent walking
#' @param speed how fast you walk, either "slow", "medium", "fast" or a numeric value in metres per second
#' @usage walk_time(minutes, speed=c("medium", slow","fast"))
#' @description The speeds are 0.8 m/s for 'slow', 1.4 m/s for 'medium' and 2.5m/s for 'fast'

walk_time<-function(minutes, speed=c("medium", "slow","fast")){
  if (is.character(speed)) {
    speed<-match.arg(speed)
    speed<-switch(speed,slow= 0.8, medium=1.4, fast=2.5)
   } else {
    if (!is.numeric(speed)) stop("speed must be numeric or one of the given options.")
  }
  minutes*60*speed
}