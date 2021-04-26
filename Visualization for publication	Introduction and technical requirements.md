# Producing Pubication and Web-Ready Visualizations

Designing and producing good quality clear illustrations and plots demostrating results is a key task in presenting reuslts in a publication. Based on a powerful tool: *ggplot2*, we discuss how to create different types of graphs, from classical box/scatter plot, to complex networks, 3D images and circular genome plots.

These two previous tutorials gave an introduction on the use of *ggplot2*:   
[Visualising data with ggplot2 I](https://github.com/liuchen37/R_tutorials/blob/main/Foundation:%20Visualising%20data%20with%20ggplot2%20I.r)  
[Visualising data with ggplot2 II](https://github.com/liuchen37/R_tutorials/blob/main/Foundation:%20Visualising%20data%20with%20ggplot2%20II.r)

Below are some examplar plots we will produce in this chapter:

**Multiple distribution**

![alt text](https://clauswilke.com/dataviz/boxplots_violins_files/figure-html/dw-nominate-ridgeline-1.png)
> [Reference](https://clauswilke.com/dataviz/boxplots-violins.html#ref-Wehrwein-Lincoln-weather)


**Coulour maps for two variable data (Haetmaps)**

![alt text](https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fbcj.2017.56/MediaObjects/41408_2017_Article_BFbcj201756_Fig3_HTML.jpg?as=webp)
> [Mitra *et al*, 2017, Blood Cacer Journal](https://www.nature.com/articles/bcj201756)

**Data in networks**

![alt text](https://journals.plos.org/plosgenetics/article/figure/image?size=large&id=info:doi/10.1371/journal.pgen.1000414.g004)
> [Bell *et al*, 2009, Plos Genetics](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1000414)

**Interactive web-based image**

> [CRUK Statistics](https://www.cancerresearchuk.org/health-professional/cancer-statistics/statistics-by-cancer-type/breast-cancer/incidence-in-situ#heading-One)

**3D graphs**

![alt text](https://d2mvzyuse3lwjc.cloudfront.net/www/resources/graph_gallery/images_galleries_new/3DSurSkipGridlineIgnorMissingValue_openGL.png)
> [Reference](https://www.originlab.com/www/products/GraphGallery.aspx?GID=198)

**Circular genome polyomic image**

![alt text](https://www.frontiersin.org/files/Articles/437351/fgene-10-00404-HTML/image_m/fgene-10-00404-g003.jpg)
> [Jiao *et al*, 2019, Frontiers in Genetics](https://www.frontiersin.org/articles/10.3389/fgene.2019.00404/full)


In order to In order to produce these images, the following environment is required:

```r
rm(list = ls())

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

install.packages("circlize",
                  "dplyr",
                  "ggridges",
                  "ploty",
                  "RColorBrewer",
                  "readr",
                  "magrittr",
                  "tidyr",
                  "viridis")
 
```
