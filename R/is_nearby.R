is_nearby<-function(to, from, graph, radius){
  names(from)<-c("x","y")
  distances<-dodgr::dodgr_dists(graph, from=from, 
                                to=as.matrix(to), wt_profile="foot")
  distances < radius
}