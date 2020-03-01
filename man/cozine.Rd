\name{cozine}
\alias{cozine}
\title{
Fitting Hurdle Normal model for composition data
}
\usage{
cozine(dat, fixed = NULL, parallel = TRUE, indices = NULL, lambda.min.ratio = 0.5)
}
\arguments{
  \item{dat}{
OTU table with nx p matrix with n samples and p texa
}
  \item{fixed}{
data.frame of fixed covariates (to be conditioned upon)
}
  \item{parallel}{
parallelize over variables using "mclapply"
}
  \item{indices}{
subset of indices to fit, useful for cluster parallelization
}
  \item{lambda.min.ratio}{
minimum lambda ratio (as a function of lambda0, where the first predictor enters; default .1)}
}
