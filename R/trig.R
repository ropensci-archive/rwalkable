## https://gis.stackexchange.com/questions/2951/algorithm-for-offsetting-a-latitude-longitude-by-some-amount-of-meters
## These take a distance in metres and return a displacement in degrees of lat or lon

radius_to_latitude<-function(radius){
  radius/111111
}

radius_to_longitude<-function(radius, latitude){
  radius/111111/cos(latitude*2*pi/360)
}