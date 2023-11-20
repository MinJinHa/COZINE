#' Turn a matrix of weights into a binary association matrix.
#' 
#' @param mat A square matrix.
#' 
#' @return Returns a binary adjacency matrix
#' 
#' @examples 
#' set.seed(123)
#' x <- matrix(abs(round(rnorm(25, 0, 0.1), 1)), nrow=5)
#' x
#' ORadj(x)
#' @export

ORadj <- function(mat) {
    stopifnot(ncol(mat)==nrow(mat))
    mat = (as.matrix(mat)!=0)
    mat = mat + t(mat)
    mat[mat>0] = 1
    mat
}
