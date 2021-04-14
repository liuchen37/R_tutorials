#1-1: Estimating differential expression
rm(list = ls())

#Load libraries
library(edgeR)
library(readr)
library(magrittr)
library(dplyr)

#1-1-1: with edgeR

#Load data
file.choose()
count <- read_tsv("file path")
glimpse(count)

#Keep the genes only
genes <- count[['gene']]
count[['gene']] <- NULL
count.matrix <- as.matrix(count)
rownames(count.matrix) <- genes

#Load phenodata
file.choose()
pheno <- readr::read_table2("file path")
glimpse(pheno)

#Specify experiments of interest
experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which(pheno[['stage']] %in% experiments_of_interest)

#Piping method to send columns of interest to group factor
grouping <- pheno[['stage']][columns_of_interest] %>% 
  forcats::as_factor()

#

#1-1-2: with DESeq2
