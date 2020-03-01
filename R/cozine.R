cozine <-
function(dat,fixed = NULL, parallel = TRUE,indices=NULL,lambda.min.ratio=0.5){
  ### Input ###
  ######### dat :  OTU table with nx p matrix with n samples and p texa
  ######### fixed: data.frame of fixed covariates (to be conditioned upon)
  ######### parallel: parallelize over variables using "mclapply"?
  ###########nlambda: number of lambda values on grid (default 200).
  
  ##########lambda.min.ratio: minimum lambda ratio (as a function of lambda0, where
        #                                  the first predictor enters; default .1)
  
  # parallelization.
   ### Output: Object from fitHurdle
  stopifnot(is.matrix(dat))
  p = ncol(dat)
  n = nrow(dat)
  dat_t = clr(dat)
  dat_trans <- conditionalCenter(dat_t)
  hf = fitHurdle(dat_trans,  fixed=fixed,lambda.min.ratio = lambda.min.ratio, parallel=parallel, control=list(debug=0),keepNodePaths = TRUE) # Using 2 cores
  return(hf) 
}
