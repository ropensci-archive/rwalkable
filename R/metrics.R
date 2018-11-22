## number of intersections per unit area was used by the Canadians
## https://www.ncbi.nlm.nih.gov/pubmed/24454837
##

get_graph_metrics<-function(graph){
  ## We're going to compact the dodgr graph and then count the vertices.
  graph<-dodgr::dodgr_compact_graph(graph)$graph
  nrow(graph)-nrow(dodgr::dodgr_vertices(graph))
}