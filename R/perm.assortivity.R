perm.assortivity <-
function(G,x,perm=T,num.perm=1000) {
  ##### G: graph object
  ##### x: node label
  assort = assortativity_nominal(G,types=x)
  if (perm) {
    # Start permutation .... 
    p = length(x) # #of nodes
    num = 0 
    assort.perm = rep(NA,num.perm)
    
    repeat {
      num = num+1
      assort.perm[num] = assortativity_nominal(G,types=x[sample(1:p)])
      if (num==num.perm){
        break
      }
    }
    return(list(value=assort,pval =mean(assort.perm>assort) ,null.value=assort.perm))
  } else{
    return(list(value=assort,pval =NULL ,null.value=NULL))
  }
}
