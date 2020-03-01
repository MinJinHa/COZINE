assortativity.phylo <-
function(A,class,graph.unit,num.perm=3000){
  ### Input
  ####### - A : adjacency matrix for network
  ####### - class : a data matrix that includes microbiome phylogenetic classification
  ####### - graph.unit: the column name of the class matrix corresponding to the unit for the microbiome network
  G = graph_from_adjacency_matrix(A)
  p = ncol(A)
  nodenames = names(V(G))
  if (sum(nodenames%in% class[,graph.unit])!=p) stop("there are some vertices that are not classified")
  #class[,graph.unit]
  w = match(nodenames,class[,graph.unit])
  owclass = class[w,-which(colnames(class)==graph.unit)]
  owclass = owclass[,-which(apply(owclass,2,function(x)length(unique(x)))<2)]
  #cbind(nodenames,class[w,graph.unit])
  outmat = matrix(nrow=ncol(owclass),ncol=3)
  outmat[,1] = colnames(owclass)
  null.values=vector("list",length=ncol(owclass))
  for (i in 1:ncol(owclass)) {
    assort.fit = perm.assortivity(G,x=as.numeric(as.factor(owclass[,i])),num.perm=num.perm)
    outmat[i,2] = assort.fit$value 
    outmat[i,3] = assort.fit$pval 
    null.values[[i]] = assort.fit$null.value
  }
  return(list(out=outmat,null.values=null.values))
}
