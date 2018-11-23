is_nearby<-function(to, from, graph, radius){
  names(from)<-c("y","x")
  distances<-dodgr::dodgr_dists(graph, from=from, 
                                to=as.matrix(to), wt_profile="foot")
  ok<-(distances < radius) 
  ok[is.na(ok)]<-FALSE
  ok
}