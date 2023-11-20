------------------------------------------------------------------------

Title: COZINE: COmpositional Zero-Inflated Network Estimation 

Author: Min Jin Ha, mjha@mdanderson.org 

Date: “3/1/2020” 

------------------------------------------------------------------------

## Overview
--------

This vignette describes how to use R/COZINE to estimate microbial
network when the abundances in each sample are constrained to have a
fixed sum and there is incomplete overlaping microbial populations
across subjects, the data are both compositional and zero-inflated.

## COZINE with example
-------------------

We illustrate the usage of R/COZINE pakcage using 86 oral samples from
newly diagnosed adult acute myeloid leukemia (AML) patients undergoing
induction chemotherapy (IC) at MD Anderson Cancer Center in Houston TX
from September 2013 to august 2015 measured at baseline before IC.
Bacterial genomic DNA was extracted and the 16S rRNA V4 region was
sequenced. The OTU counts within geneara can be loaded.

    data("iOraldat")
    dim(iOraldat)

    ## [1] 86 63

We fit COZINE, parallelizing over nodes using “mclapply”.

    hf = cozine(dat = iOraldat)

The output is the object from fitHurdle function from the HurdleNormal
package. A network with the lowest BIC value is selected and a post-hoc
symmetrization is performed to obtain the adjacency matrix.

    A = ORadj(hf$adjMat[[which.min(hf$BIC_etc$BIC)]]) # Adjacency Matrix

To check assortativity mixing over phylogenetic tree, we load the
classification data.

    data(class)

Then we compute assortativity coefficients at each of the hierarchies of
the phylogenetic tree.

    fit.assort = assortativity.phylo(A,class=class,graph.unit="Genus",num.perm=100000) 
    fit.assort$out

    ##      [,1]     [,2]                [,3]   
    ## [1,] "Phylum" "0.264279967819791" "5e-05"
    ## [2,] "Class"  "0.221379082810953" "0"    
    ## [3,] "Order"  "0.148902067639045" "2e-05"
    ## [4,] "Family" "0.102591960266956" "0"

The coefficients and the p-values are in the second and third column of
the out object/ The null.values object includes a list of the null
assortativity coefficients obtained by permuting the ancestor labels of
a phylogenetic classification.
