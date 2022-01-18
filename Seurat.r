# Seurat: https://github.com/satijalab/seurat

rm(list = ls())

# load pbmc3k
library(SeuratData)
library(Seurat)
InstallData('pbmc3k')
data('pbmc3k')
pbmc3k <- pbmc3k.final

# generate a dimension reduction  plot
DimPlot(pbmc3k, reduction = "umap", label = TRUE)
# retrieve cell type
unique(Idents(pbmc3k))
pbmc3k$celltype = Idents(pbmc3k)

# log transformation
pbmc3k <- NormalizeData(pbmc3k, normalization.method = "LogNormalize",
                        scale.factor = 1e4)
# local polynomial regress, log(variance) vs log(mean)
pbmc3k <- FindVariableFeatures(pbmc3k, selection.method = "vst",
                               nfeatures = 2000)
pbmc3k <- ScaleData(pbmc3k)
# principal component analysis
pbmc3k <- RunPCA(pbmc3k, pc.genes = VariableFeatures(pbmc3k))
# nearest neighbor construction (shared nearest neighbor) and clusters
pbmc3k <- FindNeighbors(pbmc3k, dims = 1:15)
pbmc3k <- FindClusters(pbmc3k, resolution = 0.8)
set.seed(123)
# get real coordinate for rSNE and UMAP
pbmc3k <- RunTSNE(pbmc3k, dims = 1:15, do.fast = FALSE)
pbmc3k <- RunUMAP(pbmc3k, dims = 1:15, do.fast = FALSE)

DimPlot(pbmc3k, reduction = "umap", label = TRUE)
