#' Compare assortivity of a network at various phylogenetic levels.
#' 
#' @param A  An adjacency matrix for network
#' @param class A matrix of microbiome phylogenetic information. Note any NA values will all be categorized as the same.
#' @param graph.unit The column name of the class matrix that corresponds to the unit for the microbiome network. Columns before this one will be used.
#' @param num.perm A number of permutations to run, defaults to 3000. This is passed to \code{\link{perm.assortivity}}.
#'
#' @importFrom igraph graph_from_adjacency_matrix V
#' @importFrom stats setNames
#' 
#' @keywords assortivity phylogeny permutation
#' 
#' @return Returns a list with two elements, "results" is a dataframe of results, "null.values" is a list of vectors showing null values for the permutation tests.
#' 
#' @examples 
#' x <- 4
#' @export


assortativity.phylo <- function(A, class, graph.unit, num.perm=3000){
  G = igraph::graph_from_adjacency_matrix(A)
  p = ncol(A)
  nodenames = names(igraph::V(G))
  if (sum(nodenames%in% class[,graph.unit])!=p) stop("there are some vertices that are not classified")

  w = match(nodenames,class[,graph.unit])
  owclass = class[w, -which(colnames(class)==graph.unit) ]
  owclass = owclass[, which(apply(owclass,2,function(x) length(unique(x)))>=2) ]
  owclass = apply(owclass, 2, function(c){c[is.na(c)]<-"NotFound";c})
  
  res <- lapply(1:ncol(owclass), function(i){
    perm.assortivity(G, x=as.numeric(as.factor(owclass[,i])), num.perm=num.perm)
  })
  
  res_df <- do.call(rbind,lapply(res, function(r){r$result}))
  res_df$taxa <- colnames(owclass)
  null.values <- stats::setNames(lapply(res, function(r){r$null.values}), colnames(owclass))
  
  return(list(results=res_df, null.values=null.values))
}
