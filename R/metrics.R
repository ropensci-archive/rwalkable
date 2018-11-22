## number of intersections per unit area was used by the Canadians
## https://www.ncbi.nlm.nih.gov/pubmed/24454837
##
## adhesion seems a useful additional summary

get_graph_metrics<-function(graph){
  ## actually, we need to subset this to the 'nearby' subgraph
  degree<- sum(igraph::degree(graph)>2)
  adhesion<-igraph::adhesion(graph)
  list(degree=degree,cohesion=adhesion)
}