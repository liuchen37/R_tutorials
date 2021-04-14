# Quantitative RNAseq

RNAseq is a technology which ultilises the next generation sequencing (NGS) to sequence the RNA molecules in a biological system. The technique was developed more than a decade ago, and has become ubiquitous in genetic research. With the help of RNAseq, we can answer the central question: *which gene is differentially expressed?*, referred as differencial gene expression (DGE). With technical advancements, new applications of RNAseq including studying translation (translatome), RNA structure (structurome), spatial transciptomics (spatialomics) and so on. In addition to mRNA, RNAseq can be ran on other types of RNAs, for example rRNA, tRNA and miRNA. The following graph illustrates a typical mRNA sequencing:

![alt text](https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fnrg2484/MediaObjects/41576_2009_Article_BFnrg2484_Fig1_HTML.jpg)

###### Wang, Z., Gerstein, M. & Snyder, M. RNA-Seq: a revolutionary tool for transcriptomics. *Nat Rev Genet* **10**, 57–63 (2009). https://doi.org/10.1038/nrg2484

More information please refer to the review artical published by Stark, R *et al.* (2019) on Nature Reviews Genetics: 
> Stark, R., Grzelak, M. & Hadfield, J. RNA sequencing: the teenage years. *Nat Rev Genet* **20**, 631–656 (2019). https://doi.org/10.1038/s41576-019-0150-2

In most cases, QC and alignment are done outside R. Data analysing with R will begin with a file has transcript or gene annotations (GEF or BED) and a file of aligned reads (BAM).

In order to process these data, the following environment is required:
```r
rm(list = ls())

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

BiocManager::install(c(
  "AllelicImbalance",
  "bumphunter",
  "csaw",
  "edgeR",
  "IRanges",
  "Rsamtools",
  "rtracklayer",
  "sva",
  "SummarizedExperiment",
  "VariantAnnotation"
  ))

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq")

install.packages("dplyr",
                 "extRemes",
                 "forcats",
                 "magrittr",
                 "powsimR",
                 "readr")
```
