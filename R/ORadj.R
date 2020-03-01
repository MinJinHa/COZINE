ORadj <-
function(mat) {
  ## Input
   ### mat: any pxp matrix that includes edge weights
  ## Output: adjacency matrix
    stopifnot(ncol(mat)==nrow(mat))
    mat = (as.matrix(mat)!=0)
    mat = mat + t(mat)
    mat[mat>0] = 1
    mat
}
