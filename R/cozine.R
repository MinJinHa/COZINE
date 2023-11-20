#' COZINE model fit function (wrapper for HurdleNormal::fitHurdle)
#' 
#' This will perform a centered log ratio transform with additional centering of the data, then fit a hurdle model to it per HurdleNormal::fitHurdle
#' 
#' @param dat A data frame or matrix of OTU/ASV counts.
#' @param fixed a data.frame of fixed covariates (to be conditioned upon). Passed to fitHurdle's fixed argument
#' @param parallel Logical, should parallel::mclapply be used in HurdleNormal::fitHurdle? Defaults to TRUE.
#'  Note that fitHurdle does not allow you to pass a number of cores directly,
#'  so the "MC_CORES" option will need to be set to parallelize (\code{options(MC_CORES=4)})
#' @param lambda.min.ratio minimum lambda ratio (as a function of lambda0, where
#                                  the first predictor enters; default .1)
#' @param ... Additional arguments passed to HurdleNormal::fitHurdle. By default control has debug=0 and keepNodePaths is set to TRUE.
#'
#' @importFrom compositions clr
#' @importFrom HurdleNormal fitHurdle conditionalCenter
#' @importFrom methods is
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

cozine <- function(dat,fixed = NULL, parallel = TRUE, lambda.min.ratio=0.1, ...){
  if(methods::is(dat, "data.frame")){
    dat <- as.matrix(dat)
  } else if(!methods::is(dat, "matrix")){
    stop("dat must be a data.frame or matrix")
  }
  p = ncol(dat)
  n = nrow(dat)
  dat_t = compositions::clr(dat)
  dat_trans <- HurdleNormal::conditionalCenter(dat_t)
  hf = HurdleNormal::fitHurdle(dat_trans,  fixed=fixed, lambda.min.ratio = lambda.min.ratio, parallel=parallel, control=list(debug=0),
                 keepNodePaths = TRUE, ...) 
  return(hf) 
}
