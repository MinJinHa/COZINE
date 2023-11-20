#' Permutation test for a network node's assortivity
#' 
#' @param G An igraph object
#' @param x Node labels from G as a numeric vector.
#' @param num.perm A number of permutations to run, defaults to 1000.
#'
#' @importFrom igraph assortativity_nominal
#' 
#' @keywords assortivity phylogeny permutation
#' 
#' @return Returns a list with two elements
#' The first element "result" is a datafram with two columns. "Value" is the observed nominal assortivity of node x, "p.value" is the percentage of permuted scores below that value.
#' The second element, "null.value", is the list of permuted assortivity scores. 
#' 
#' @examples 
#' x <- 4
#' @export

perm.assortivity <- function(G, x, num.perm=1000) {
  assort = igraph::assortativity_nominal(G,types=x)
  p = length(x)
  
  assort.perm <- unlist(lapply(1:num.perm, function(i){
    igraph::assortativity_nominal(G, types = x[sample(1:p)])
  }))
  return(list(result = data.frame(value=assort, pval =mean(assort.perm > assort, na.rm=TRUE) ) , null.value=assort.perm))
}
